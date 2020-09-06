# Day 1
* Find useful feature for Neural Network
## Feature selection with Boruta Algorithm:
* get most important features from dataset using RF

## feature extraction from time domain :
1. Mean of : 
	* horizonal forward and vertical acceleration of ankle sensor(X1,Y1)
	* horizontal lateral of trunk (Z3)
2. RMS
	* vertical acceleration of ankle sensor(Y1)
3. Proportion of data above and below mean(Y1)
4. Sum of change(X2)

## feature extraction from frequency domain :

1. Freezing Index

# Day 3

## Hardware 

* Get familliar with the uart example provided by nRF52 SDK 15.03

* Write a c code running on linux to send dataset to board

* Write embedded code on board to receive code and save in an array

* BUG : The data received on the board is corrupted

# Day 4

* Get familliar with the DSP library and try the fast fourier transform example provided by the SDK. 

* Learn to configure in sdk_configure.h file and enable certain functions of nRF52.

* Try to run fft_transform function in my own project.

* Try to solve the BUG of fast transmission of UART by adding some signal exchange (ack signals) between several chars (9 integers, 36 chars) to coordinate the transmission.

* Add some check code after receive a whole window from uart.

* NEW BUG : the screen stucks after several receiving for some time. I think it might due to some buffer gets filled, so I tried to flush buffer of open device file and uart fifo on the board. It does not help.


# Day 5

* Try to fix the bug of UART transmission.

* Write a bash to call the tranmission program several times, it works good and fluently through all windows in S01R01.txt

* NEW BUG: The data received on the buffer is still corrupted. 

* Change the baud rate to 9600 and ack between each (36*4 char, 36 integers), works fine.

* Run the FFT transform function with received data, the results corresponds much to the FFT result on matlab.


# Day 6

* Find a way to fix the of UART transmission (by opening gtkterm and then close it; No idea why this work...) able to transfer data at highest speed(115200) with no signal coordination.

* User can control the flow of UART transmission and give feedback using buttons.

* Success perform rms, mean, fft on the board.

* Write a Neural Network in C; I think LSTM is a better solution maybe.(try it later) 

* Go through knowledge about Reinforcement learning.

