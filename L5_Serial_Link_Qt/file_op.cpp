#include <file_op.h>

 file_op::file_op()
 {
     memset(lda_features, 0.0, sizeof(float)*18);
     lda_features[1][0]=1;
     lda_features[1][5]=1;
     lda_features[1][6]=1;

     thresholds_params[0]=1.0;
     thresholds_params[7]=5.0;


     feature_names <<"step interval"<<"step depth"<<"sumLoco"<<"sumFreeze"<<"sumHP"<<"freeingIndex"<<"Dominant frequency"<<"smoothness"<<"portion";
     thresholds[0]=1;
     thresholds[7]=1;


 }

void::file_op::read_next_window(FILE* archivo)
{

    long int timeP;
    int result;
    int i=0;
    fseek(archivo,file_ptr,SEEK_SET);;

    while(feof(archivo)==0 && i<SR*w)
    {
        fscanf(archivo, "%ld %d %d %d %d %d %d %d %d %d %d",&timeP,&matrix_wt[i][0],&matrix_wt[i][1],&matrix_wt[i][2],&matrix_wt[i][3],&matrix_wt[i][4],&matrix_wt[i][5],&matrix_wt[i][6],&matrix_wt[i][7],&matrix_wt[i][8],&result	);
        if(i==stepsize-1)
        {
            file_ptr = ftell(archivo);
        }
        i++;
    }


    qDebug() << "finished reading out data";



}

void::file_op::send_parameters(QextSerialPort* port)
{
    QByteArray mysignal;
    mysignal.append(signal_para);
    mysignal.append('\r');
    qDebug()<<"\r\nsending\r\n"<<mysignal;
    port->write(mysignal);
    mysignal.clear();
    //int data_buffer = 0;

    //send threholds depth
    for(int j=0;j<9;j++)
    {
        sending_info(&step_depth[j],port);
    }

    qDebug()<<"\r\nsending threshold data ";
    //send threholds data
    for(int j=0;j<9*9;j++)
    {
        sending_info(&THS[(j/9)][j%9],port);
    }

    qDebug()<<"\r\nsending lda mask ";
    //send lda info
    for(int j=0;j<81;j++)
    {
         sending_info(&mask[(j/9)][j%9],port);
    }

    qDebug()<<"\r\nsending lda paras ";
    //send lda info
    for(int j=0;j<81;j++)
    {
         sending_info(&W[(j/9)][j%9],port);
    }

    sending_info(&dtth,port);
    sending_info(&TG,port);

}


void::file_op::send_next_window(QextSerialPort* port)
{
    unsigned char data[4]={0};

    QByteArray mysignal;

    /*mysignal.append(signal_p);
    mysignal.append('\r');
    qDebug()<<"\r\nsending\r\n"<<mysignal;

    port->write(mysignal);
    mysignal.clear();*/

    qDebug()<<"\r\nsending signal\r\n";
    for(int i=0;i<1;i++)
    {

        qDebug()<<"start to send new row\r\n";


        for(int j=0;j<9*128;j++)
        {

            data[3] = 0xFF&matrix_wt[(i)*128+(j/9)][j%9];
            data[2] = (matrix_wt[(i)*128+(j/9)][j%9]>>8)&0xFF;
            data[1] = (matrix_wt[(i)*128+(j/9)][j%9]>>16)&0xFF;
            data[0] = (matrix_wt[(i)*128+(j/9)][j%9]>>24)&0xFF;

            for(int k=0;k<4;k++)
            {
                mysignal.append(data[k]);
            }

            mysignal.append('\r');
            qDebug()<<j/9<<"\r\nreading\r\n"<<matrix_wt[i][j];
            //qDebug()<<"\r\ntranslating\r\n"<<data[0]<<data[1]<<data[2]<<data[3];

            port->write(mysignal);

  //          qDebug()<<"\r\nsending\r\n"<<mysignal.toInt();
            mysignal.clear();

        }


    }

}

void::file_op::read_parameters(QString* name1,QString* name2,QString* info)
{
    QFile file(*name1);
    QByteArray byteArray;


    if(!file.open(QIODevice::ReadOnly))
    {
       qDebug() << "error opening file: " << file.error();
       *info = "error opening thresholds file: ";
       return;
    }
    memset(thresholds_data, 0.0, sizeof(float)*81);


    //read out thresholds
    int counter=0;
    foreach (QString i,QString(file.readAll()).split(QRegExp("[\r\n]"),QString::SkipEmptyParts)){

        //*info = *info + "\r\nTH number is: " + QString::number(th);

        foreach (QString n,i.split(QRegExp(" "),QString::SkipEmptyParts)){
            if(counter<=8){
                step_depth[counter] = n.toFloat();
                 *info = *info+"\r\nGET step_depth: " + QString::number(step_depth[counter] );
            }
            if(counter>8 &&counter<=89  ){
                THS[(counter-9)%9][(counter-9)] = n.toFloat();
                 *info = *info+"\r\nGET thresholds: " + QString::number(THS[(counter-9)%9][(counter-9)] );
            }
            if(counter>89 &&counter<=89+81  ){
                mask[(counter-89)%9][(counter-89)] = n.toFloat();
                 *info = *info+"\r\nGET mask: " + QString::number(mask[(counter-89)%9][(counter-89)] );
            }
            if(counter>89+81 &&counter<=89+81*2  ){
                W[(counter-170)%9][(counter-170)] = n.toFloat();
                 *info = *info+"\r\nGET W: " + QString::number(W[(counter-170)%9][(counter-170)] );
            }
            if(counter==89+81*2+1){
                dtth=n.toFloat();
                 *info = *info+"\r\nGET dtth: " + QString::number(dtth);
            }

            if(counter==89+81*2+2){
                TG=n.toFloat();
                 *info = *info+"\r\nGET TG: " + QString::number(TG);
            }

            counter++;
        }
    }


    qDebug() << "finish reading TH\r\n";


}

void::file_op::sending_info(float* Data,QextSerialPort* port){
    QByteArray mysignal;
    unsigned char data[4]={0};
    int data_buffer = 0;
    data_buffer = *((int*)(Data));
    data[3] = 0xFF&data_buffer;
    data[2] = (data_buffer>>8)&0xFF;
    data[1] = (data_buffer>>16)&0xFF;
    data[0] = (data_buffer>>24)&0xFF;

    for(int k=0;k<4;k++)
    {
        mysignal.push_back(data[k]);
    }

    mysignal.append('\r');
    qDebug()<<" reading data "<<*Data;
    //qDebug()<<"\r\n"<<j<<" reading "<<data[0]<<data[1]<<data[2]<<data[3];
    port->write(mysignal);
    mysignal.clear();


}
