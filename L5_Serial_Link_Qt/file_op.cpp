#include <file_op.h>

 file_op::file_op()
 {
     memset(lda_features, 0.0, sizeof(float)*18);
     lda_features[1][2]=1;
     lda_features[1][5]=1;
     lda_features[1][6]=1;


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
    unsigned char data[4]={0};

    QByteArray mysignal;
    mysignal.append(signal_para);
    mysignal.append('\r');
    qDebug()<<"\r\nsending\r\n"<<mysignal;
    port->write(mysignal);
    mysignal.clear();
    int data_buffer = 0;

    //send threholds info
    for(int j=0;j<9;j++)
    {

        data_buffer = thresholds[j];
        data[3] = 0xFF&data_buffer;
        data[2] = (data_buffer>>8)&0xFF;
        data[1] = (data_buffer>>16)&0xFF;
        data[0] = (data_buffer>>24)&0xFF;

        for(int k=0;k<4;k++)
        {
            mysignal.push_back(data[k]);
        }

        mysignal.append('\r');
        qDebug()<<j<<" reading threholds data "<<thresholds[j];
        //qDebug()<<"\r\n"<<j<<" reading "<<data[0]<<data[1]<<data[2]<<data[3];
        port->write(mysignal);
        mysignal.clear();
    }

    //send threholds data
    for(int j=0;j<9*9;j++)
    {

        data_buffer = *((int*)(&thresholds_data[(j/9)][j%9]));
        data[3] = 0xFF&data_buffer;
        data[2] = (data_buffer>>8)&0xFF;
        data[1] = (data_buffer>>16)&0xFF;
        data[0] = (data_buffer>>24)&0xFF;

        for(int k=0;k<4;k++)
        {
            mysignal.push_back(data[k]);
        }

        mysignal.append('\r');
        qDebug()<<j<<" reading "<<thresholds_data[(j/9)][j%9];
        //qDebug()<<"\r\n"<<j<<" reading "<<data[0]<<data[1]<<data[2]<<data[3];
        port->write(mysignal);
        mysignal.clear();

    }

    qDebug()<<"\r\nsending lda info ";
    //send lda info
    for(int j=0;j<18;j++)
    {

        data_buffer =  *((int*)(&lda_features[(j/9)][j%9]));
        data[3] = 0xFF&data_buffer;
        data[2] = (data_buffer>>8)&0xFF;
        data[1] = (data_buffer>>16)&0xFF;
        data[0] = (data_buffer>>24)&0xFF;

        for(int k=0;k<4;k++)
        {
            mysignal.append(data[k]);
        }

        mysignal.append('\r');
        qDebug()<<j<<" reading lda info "<<lda_features[j/9][j%9];
        //qDebug()<<"\r\n"<<j<<" reading "<<data[0]<<data[1]<<data[2]<<data[3];
        port->write(mysignal);
        mysignal.clear();
    }

    qDebug()<<"\r\nsending lda data ";
    //send lda info
    for(int j=0;j<81;j++)
    {

        data_buffer =  *((int*)(&lda_data[(j/9)][j%9]));
        data[3] = 0xFF&data_buffer;
        data[2] = (data_buffer>>8)&0xFF;
        data[1] = (data_buffer>>16)&0xFF;
        data[0] = (data_buffer>>24)&0xFF;

        for(int k=0;k<4;k++)
        {
            mysignal.append(data[k]);
        }

        mysignal.append('\r');
        qDebug()<<j<<" reading lda data "<<lda_data[j/9][j%9];
        //qDebug()<<"\r\n"<<j<<" reading "<<data[0]<<data[1]<<data[2]<<data[3];
        port->write(mysignal);
        mysignal.clear();
    }




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
        /*
        mysignal.append(signal_b);
        mysignal.append('\r');
        qDebug()<<"\r\nsending\r\n"<<mysignal;
        port->write(mysignal);

        mysignal.clear();*/

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
    int th=0;
    int sensor=0;
   // QString info;

    if(!file.open(QIODevice::ReadOnly))
    {
       qDebug() << "error opening file: " << file.error();
       *info = "error opening thresholds file: ";
       return;
    }
    memset(thresholds_data, 0.0, sizeof(float)*81);


    //read out thresholds
    foreach (QString i,QString(file.readAll()).split(QRegExp("[\r\n]"),QString::SkipEmptyParts)){

        while(thresholds[th]!=1){
            th++;
        }
        *info = *info + "\r\nTH number is: " + QString::number(th);

        foreach (QString n,i.split(QRegExp(" "),QString::SkipEmptyParts)){
                    thresholds_data[th][sensor] = n.toFloat();
                    *info = *info+"\r\nGET PARAMETER: " + QString::number(thresholds_data[th][sensor]);
                    sensor++;
        }
        sensor=0;
        th++;
    }
    qDebug() << "finish reading TH\r\n";

    //choose which parameter file to open
    QFile file2(*name2);

    if(!file2.open(QIODevice::ReadOnly))
    {
       qDebug() << "error opening file: " << file.error();
       *info = *info+ "error opening thresholds file: ";
       return;
    }
    memset(lda_data, 0.0, sizeof(float)*81);
    //read out thresholds
    int flag=1;
    int info_counter=0;
    th=0;
    foreach (QString i,QString(file2.readAll()).split(QRegExp("[\r\n]"),QString::SkipEmptyParts)){
        if(flag==1)
        {
            foreach (QString n,i.split(QRegExp(" "),QString::SkipEmptyParts)){
                lda_features[0][info_counter] = n.toFloat();
                *info = *info + "\r\nGET INFO: " + QString::number(lda_features[0][info_counter]);
                info_counter++;
            }
            flag=0;
            qDebug() << "finish reading info\r\n";
        }
        else {
            while(lda_features[1][th]!=1){
                th++;
                //qDebug() << "finish reading lda\r\n"<<QString::number(th);
            }
            qDebug() << "GET lda\r\n"<<QString::number(th);
            *info = *info + "\r\n LDA number is: " + QString::number(th);
            foreach (QString n,i.split(QRegExp(" "),QString::SkipEmptyParts)){
                        lda_data[th][sensor] = n.toFloat();
                        *info = *info+ "\r\nGET PARAMETER: " + QString::number(lda_data[th][sensor]);
                        sensor++;
            }
            sensor=0;
            th++;
        }

    }
    qDebug() << "finish reading LDA\r\n";
   // return &info;

}
