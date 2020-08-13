#ifndef FILE_OP_H
#define FILE_OP_H

#endif // FILE_OP_H

#include <QFile>
#include <QDebug>
#include "qextserialport.h"         // Enables use of the qextserialport library.
#include <QMessageBox>


class file_op
{
public:
     unsigned char signal_p = '<';
     unsigned char signal_b = ':';
     unsigned char signal_para = '!';

     int SR = 64;
     int stepsize = 32;
     int w = 2;
     int matrix_wt[128][9];
     long int file_ptr;
     int Tn=9;
     int thresholds[9]={0};
     float lda_features[2][9];
     float thresholds_data[9][9];
     float lda_data[9][9];
    file_op();
    void read_next_window(FILE* archivo);
    void send_next_window(QextSerialPort* port);
    void send_parameters(QextSerialPort* port);
    void read_parameters(QString* name1,QString* name2,QString* info);
};
