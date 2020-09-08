#-------------------------------------------------
#
# Project created by QtCreator 2014-09-16T13:58:43
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets printsupport

TARGET = SerialLink
TEMPLATE = app


SOURCES += main.cpp\
        file_op.cpp \
        mainwindow.cpp \
    qcustomplot.cpp




HEADERS  += mainwindow.h \
    file_op.h \
    qcustomplot.h


FORMS    += mainwindow.ui

#-------------------------------------------------
# This section will include QextSerialPort in
# your project:

HOMEDIR = $$(HOME)
include($$HOMEDIR/qextserialport/src/qextserialport.pri)
include(qextserialport/src/qextserialport.pri)

# Before running the project, run qmake first:
# In Qt Creator, right-click on the project
# and choose "run qmake".
# The qextserialport folder should appear in the
# directory tree.
# Now your project is ready to run.
#-------------------------------------------------

RESOURCES += \
    chessResource/picture.qrc

DISTFILES += \
    chessResource/people.png \

