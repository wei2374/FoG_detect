#include <QProcess>

#include "mainwindow.h"
#include "ui_mainwindow.h"



// Constructor of the MainWindow object.
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    // Get all available COM Ports and store them in a QList.
    QList<QextPortInfo> ports = QextSerialEnumerator::getPorts();

    // Read each element on the list, but
    // add only USB ports to the combo box.
    for (int i = 0; i < ports.size(); i++) {
        if (ports.at(i).portName.contains("ACM")){
            ui->comboBox_Interface->addItem(ports.at(i).portName.toLocal8Bit().constData());
        }
    }
    // Show a hint if no USB ports were found.
    if (ui->comboBox_Interface->count() == 0){
        ui->textEdit_Status->insertPlainText("No USB ports available.\nConnect a USB device and try again.");
    }
    ui->patient->setStyleSheet("background-image: url(:/new/prefix1/patient.png);");
    ui->parameterButton_send_2->setEnabled(true);
    ui->dataButton->setEnabled(true);
    ui->training_data->setEnabled(true);
    myfile.lda_features[0][3] = 6;
    ui->ankle_button->setStyleSheet("background-color:green;");
    ui->knee_button->setStyleSheet("background-color:green;");
}

// Destructor of the MainWindow object.
MainWindow::~MainWindow()
{
    delete ui;
}

// SLOT: Configures the serial port upon clicking the "open" button.
void MainWindow::on_pushButton_open_clicked() {

    // The instance of qextserialport is configured like so:
    port.setQueryMode(QextSerialPort::EventDriven);
    port.setPortName("/dev/" + ui->comboBox_Interface->currentText());
    port.setBaudRate(BAUD115200);
    port.setFlowControl(FLOW_OFF);
    port.setParity(PAR_NONE);
    port.setDataBits(DATA_8);
    port.setStopBits(STOP_1);

    // Open sesame!!
    port.open(QIODevice::ReadWrite);

    // Check if the port opened without problems.
    if (!port.isOpen())
    {
        error.setText("Unable to open port!");
        error.show();
        return;
    }

    /* This is where the MAGIC HAPPENS and it basically means:
     *      If the object "port" uses its "readyRead" function,
     *      it will trigger MainWindow's "receive" function.
     */
    QObject::connect(&port, SIGNAL(readyRead()), this, SLOT(receive()));

    // Only ONE button can be enabled at any given moment.
    ui->pushButton_close->setEnabled(true);
    ui->pushButton_open->setEnabled(false);
    ui->comboBox_Interface->setEnabled(false);

    ui->dataButton->setEnabled(true);
}

// SLOT: Closes the port and re-enables the open button.
void MainWindow::on_pushButton_close_clicked()
{
    if (port.isOpen())port.close();
    ui->pushButton_close->setEnabled(false);
    ui->pushButton_open->setEnabled(true);
    ui->comboBox_Interface->setEnabled(true);

    ui->parameterButton_send->setEnabled(false);

    ui->dataButton->setEnabled(true);
}

// SLOT: Sends parameters to the USB port.
void MainWindow::on_pushButton_send_clicked() {

}




// SLOT: Prints data received from the port on the QTextEdit widget.
void MainWindow::receive()
{
    QByteArray data = port.readAll();
    ui->textEdit_Status->insertPlainText(data);
}




void MainWindow::on_parameterButton_send_clicked()
{
    myfile.send_parameters(&port);
}

void delay()
{
    QTime dieTime= QTime::currentTime().addSecs(1);
    while (QTime::currentTime() < dieTime)
        QCoreApplication::processEvents(QEventLoop::AllEvents, 100);
}

void MainWindow::on_dataButton_clicked()
{
    qDebug() << "IN HANDLER ";

    QByteArray rec_data;
    bool rec_code=false;


    int indexP;

    // Decide which patient
    indexP = ui->combobox_p->currentIndex()+1;
    QString p=QString::number(indexP);

    QString filename = homePath+"/FoG_detect/dataset/S0"+p+"R01.txt";
    if(indexP==2)
        filename = homePath+"/FoG_detect/dataset/S0"+p+"R02.txt";

    QByteArray ba = filename.toLocal8Bit();
    const char *c_str2 = ba.data();
    FILE* archivo = fopen(c_str2,"r");

    if(archivo==NULL){
        qDebug() <<filename<< "no file found";
        exit(EXIT_FAILURE);
    }

    int counter=0;
    while(counter<2)
    {
        myfile.read_next_window(archivo);
        myfile.send_next_window(&port);
        qDebug() << "WAITING FOR ACK THE BATCH"<<(counter+1);


        while(!rec_code){
            qDebug() << "WAITING FOR ACK THE BATCH"<<(counter+1);
            rec_data = port.readAll();
            ui->textEdit_Status->insertPlainText(rec_data);
            rec_code =  rec_data.contains(myfile.signal_b);
        }
        delay();
        rec_code=false;

        counter++;
     }
}

void MainWindow::on_parameterButton_send_2_clicked()
{
    char random=4;
    qDebug()<<random/2;
    int indexP;
    // Decide which patient
    indexP = ui->combobox_p->currentIndex()+1;
    QString p=QString::number(indexP);

    int indexC;
    // Decide which classifier
    indexC = ui->combobox_c->currentIndex()+1;
    QString c=QString::number(indexC);

    int indexM;
    // Decide which classifier
    indexC = ui->combobox_m->currentIndex()+1;
    QString m=QString::number(indexM);


    qDebug() << "Patient: " << p<< "\r\n SensorsN: " << sensorN<< "Classifier"<<indexC;
    //choose which parameter file to open

    QString name1 = homePath+"/FoG_detect/PYTHON_IM/Parameters/P"+p+"T"+".txt";
    QString info;
    myfile.read_parameters(&name1,&info);


    qDebug()<<"return with SUC";
   // ui->textEdit_Status->insertPlainText(info);
    ui->parameterButton_send->setEnabled(true);

}

void MainWindow::on_training_data_clicked()
{
    QProcess p;
    QStringList params;
    QString p_stdout;

    QString filename = homePath+"/FoG_detect/PYTHON_IM/main_loop.py";
    QByteArray ba = filename.toLocal8Bit();
    const char *c_str2 = ba.data();
    params.append(c_str2);

    int indexP;
    // Decide which patient
    indexP = ui->combobox_p->currentIndex()+1;
    QString patient=QString::number(indexP);
    params.append(patient);

    int indexC;
    // Decide which classifier
    indexC = ui->combobox_c->currentIndex()+1;
    QString c=QString::number(indexC);

    int indexM;
    // Decide which mode
    indexM = ui->combobox_m->currentIndex()+1;
    QString m=QString::number(indexM);

    //Print out which patient is selected
    p_stdout = "\r\n Patient"+patient+"is selected";
    ui->textEdit_Status->insertPlainText(p_stdout);

    //Print out How many sensors are used
    p_stdout = "\r\n Sensor number is"+QString::number(sensorN);
    ui->textEdit_Status->insertPlainText(p_stdout);
    params.append(QString::number(sensorN));

    // Print out threhold features selected
     ui->textEdit_Status->insertPlainText("\r\n Threhold features\r\n");
    for(int i=0;i<9;i++){
        if(myfile.thresholds[i]==1){
                    p_stdout = "\r\n"+myfile.feature_names.at(i)+"is selected as one threshold feature"+" parameter is "+QString::number(float(myfile.thresholds_params[i]));
                    ui->textEdit_Status->insertPlainText(p_stdout);
                    params.append("1");
                    params.append(QString::number(myfile.thresholds_params[i]));
        }
        else {
            params.append("0");
            params.append("0");
        }

    }



    // Print out lda features selected
    //ui->textEdit_Status->insertPlainText("\r\n LDA features\r\n");
    for(int i=0;i<9;i++){
        if(myfile.lda_features[1][i]==1.0){
            p_stdout = "\r\n"+myfile.feature_names.at(i)+"is selected as one lda feature";
            ui->textEdit_Status->insertPlainText(p_stdout);
            params.append("1");
        }
        else
            params.append("0");
    }



    // Print out which classifier selected
    p_stdout = "\r\n"+c+"is selected as classifier";
    ui->textEdit_Status->insertPlainText(p_stdout);
    params.append(c);

    // Print out which configuration mode is selected
    p_stdout = "\r\n"+m+"is selected as configuration mode";
    ui->textEdit_Status->insertPlainText(p_stdout);
    params.append(m);

    qDebug() << "\r\n start train data";
    p_stdout = "\r\n Call the training function ...";
    ui->textEdit_Status->insertPlainText(p_stdout);

     p.start("python2.7", params);
    if(p.waitForStarted(-1)){
        while(p.waitForReadyRead(-1)){
            QByteArray a = p.readAllStandardOutput();
            QByteArray b = p.readAllStandardError();
            qDebug()<<b;
            p_stdout = QString(a);
            ui->textEdit_Status->insertPlainText(p_stdout);
            delay();
        }
    }

    qDebug()<<"Finish";
    p.waitForFinished(-1);
    qDebug() << "\r\n finished train data";
    qDebug() << "\r\n Display training result...";

    p_stdout = p.readAll();
    ui->textEdit_Status->insertPlainText(p_stdout);
    setupQuadraticDemo(ui->widget);

}
void MainWindow::setupQuadraticDemo(QCustomPlot *customPlot)
{
  //demoName = "Quadratic Demo";
  // generate some data:
  QVector<float> x,y;
  QString name1 = homePath+"/FoG_detect/PYTHON_IM/DATA/P1.txt";
  QFile file(name1);
  foreach (QString i,QString(file.readAll()).split(QRegExp("[\r\n]"),QString::SkipEmptyParts)){
    x.push_back(i.toFloat());
  }

  QString name2 = homePath+"/FoG_detect/PYTHON_IM/DATA/L1.txt";
  QFile file2(name2);
  foreach (QString i,QString(file2.readAll()).split(QRegExp("[\r\n]"),QString::SkipEmptyParts)){
    y.push_back(i.toFloat());
  }
  qDebug()<<x.size();
  qDebug()<<y.size();
/*
  QVector<double> x(101), y(101); // initialize with entries 0..100
  for (int i=0; i<101; ++i)
  {
    x[i] = i/50.0 - 1; // x goes from -1 to 1
    y[i] = x[i]*x[i];  // let's plot a quadratic function
  }


  // create graph and assign data to it:
  customPlot->addGraph();

  customPlot->graph(0)->setData(x, y);


  // give the axes some labels:
  customPlot->xAxis->setLabel("x");
  customPlot->yAxis->setLabel("y");
  // set axes ranges, so we see all data:
  customPlot->xAxis->setRange(-1, 1);
  customPlot->yAxis->setRange(0, 1);*/
}
void MainWindow::on_T0_stateChanged(int arg1)
{
    myfile.thresholds[0] = arg1/2;
    qDebug() << "interval state: " << myfile.thresholds[0];
}

void MainWindow::on_T1_stateChanged(int arg1)
{
    myfile.thresholds[1] = arg1/2;
    qDebug() << "auto-correlation state: " << myfile.thresholds[1];
}

void MainWindow::on_T2_stateChanged(int arg1)
{
    myfile.thresholds[2] = arg1/2;
    qDebug() << "locomotion state: " << myfile.thresholds[2];
}

void MainWindow::on_T3_stateChanged(int arg1)
{
    myfile.thresholds[3] = arg1/2;
    qDebug() << "Freeze state: " << myfile.thresholds[3];
}

void MainWindow::on_T4_stateChanged(int arg1)
{
    myfile.thresholds[4] = arg1/2;
    qDebug() << "HP state: " << myfile.thresholds[4];
}

void MainWindow::on_T5_stateChanged(int arg1)
{
    myfile.thresholds[5] = arg1/2;
    qDebug() << "FI state: " << myfile.thresholds[5];
}


void MainWindow::on_T6_stateChanged(int arg1)
{
   myfile.thresholds[6] = arg1/2;
    qDebug() << "DF state: " << myfile.thresholds[6];
}

void MainWindow::on_T7_stateChanged(int arg1)
{
    myfile.thresholds[7] = arg1/2;
    qDebug() << "smoothness state: " << myfile.thresholds[7];
}

void MainWindow::on_T8_stateChanged(int arg1)
{
    myfile.thresholds[8] = arg1/2;
    qDebug() << "portion state: " << myfile.thresholds[8];
}



void MainWindow::on_ankle_button_clicked()
{
    static int counter=0;
    if(counter%2==0){
        sensorN=3;
        myfile.lda_features[0][3] = 3;
        ui->ankle_button->setStyleSheet("background-color:green;");


    }
    else {
        sensorN=0;
        myfile.lda_features[0][3] = 0;
        ui->ankle_button->setStyleSheet("background-color:white;");


    }
    counter++;
}

void MainWindow::on_knee_button_clicked()
{
    static int counter=0;
    if(counter%2==0){
        sensorN=6;
        myfile.lda_features[0][3] = 6;
        ui->ankle_button->setStyleSheet("background-color:green;");
        ui->knee_button->setStyleSheet("background-color:green;");
    }
    else {
        sensorN=0;
        myfile.lda_features[0][3] = 0;
        ui->ankle_button->setStyleSheet("background-color:white;");
        ui->knee_button->setStyleSheet("background-color:white;");
    }
    counter++;
}

void MainWindow::on_waist_button_clicked()
{
    static int counter=0;
    if(counter%2==0){
        sensorN=9;
        myfile.lda_features[0][3] = 9;
        ui->ankle_button->setStyleSheet("background-color:green;");
        ui->knee_button->setStyleSheet("background-color:green;");
        ui->waist_button->setStyleSheet("background-color:green;");
    }
    else {
        sensorN=0;
        myfile.lda_features[0][3] = 0;
        ui->ankle_button->setStyleSheet("background-color:white;");
        ui->knee_button->setStyleSheet("background-color:white;");
        ui->waist_button->setStyleSheet("background-color:white;");
    }
    counter++;
}

void MainWindow::on_T0_3_stateChanged(int arg1)
{
    myfile.lda_features[1][0] = arg1/2;
    qDebug() << "interval lda: " << myfile.lda_features[0];
}

//TODO:: add more features

void MainWindow::on_T1_3_stateChanged(int arg1)
{
    myfile.lda_features[1][1] = arg1/2;
    qDebug() << "auro-correlation lda: " << myfile.lda_features[1];
}

void MainWindow::on_T2_3_stateChanged(int arg1)
{
    myfile.lda_features[1][2] = arg1/2;
    qDebug() << " locomotion lda: " << myfile.lda_features[2];
}

void MainWindow::on_T3_3_stateChanged(int arg1)
{
    myfile.lda_features[1][3] = arg1/2;
    qDebug() << " freeze lda: " << myfile.lda_features[3];
}

void MainWindow::on_T4_3_stateChanged(int arg1)
{
    myfile.lda_features[1][4] = arg1/2;
    qDebug() << " HP lda: " << myfile.lda_features[4];
}

void MainWindow::on_T5_3_stateChanged(int arg1)
{
    myfile.lda_features[1][5] = arg1/2;
    qDebug() << " fi lda: " << myfile.lda_features[5];
}

void MainWindow::on_T6_3_stateChanged(int arg1)
{
    myfile.lda_features[1][6] = arg1/2;
    qDebug() << " dominant frequency lda: " << myfile.lda_features[6];
}

void MainWindow::on_T7_3_stateChanged(int arg1)
{
    myfile.lda_features[1][7] = arg1/2;
    qDebug() << " smoothness lda: " << myfile.lda_features[7];
}

void MainWindow::on_T8_3_stateChanged(int arg1)
{
    myfile.lda_features[1][8] = arg1/2;
    qDebug() << " portion lda: " << myfile.lda_features[8];
}



void MainWindow::on_T0s_valueChanged(int value)
{
    myfile.thresholds_params[0] = float(value)/10;
    ui->lcdNumber->display(value*10);
}

void MainWindow::on_T1s_valueChanged(int value)
{
    myfile.thresholds_params[1] = float(value)/10;
    ui->lcdNumber_2->display(value*10);
}

void MainWindow::on_T2s_valueChanged(int value)
{
    myfile.thresholds_params[2] = float(value)/10;
    ui->lcdNumber_3->display(value*10);
}

void MainWindow::on_T3s_valueChanged(int value)
{
    myfile.thresholds_params[3] = float(value)/10;
    ui->lcdNumber_4->display(value*10);
}

void MainWindow::on_T4s_valueChanged(int value)
{
    myfile.thresholds_params[4] = float(value)/10;
    ui->lcdNumber_5->display(value*10);
}

void MainWindow::on_T5s_valueChanged(int value)
{
    myfile.thresholds_params[5] = float(value)/10;
    ui->lcdNumber_6->display(value*10);
}

void MainWindow::on_T6s_valueChanged(int value)
{
    myfile.thresholds_params[6] = float(value)/10;
    ui->lcdNumber_7->display(value*10);
}

void MainWindow::on_T7s_valueChanged(int value)
{
    myfile.thresholds_params[7] = float(value)/10;
    ui->lcdNumber_8->display(value*10);
}

void MainWindow::on_T8s_valueChanged(int value)
{
    myfile.thresholds_params[8] = float(value)/10;
    ui->lcdNumber_9->display(value*10);
}


