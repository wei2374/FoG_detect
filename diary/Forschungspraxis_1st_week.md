#Day1
Downloading the software development kit and try to compile the example code of blink led and uart communication on eclipse with GNU ARM cross compiler.

#Day 3
paper analysis:

## How to deal with accelerometer data?(Feature extraction)

1. LDA, PCA, kernel-PCA, kernel-LDA; black box dimension reduction
2. FFT and get FoG index; 
3. Discrete Wavelet Transformation; Get data from low frequency domain
3. sample entropy ?

## How should we design classifier 

1. SVM : muliple classifier is needed for multiple class;
2. Random Forest : too much memory requirement for additional decision trees;
3. KNN : too much memory requirement for training data; Not suitable for online training
4. NN classifier : viable for small memory device
5. Reinforcement learning

## Neural Network and RL
1. learns basic about NN and did the mnist dataset example with keras in python
2. Go through basic knowledge about reinforcement learning


# DAY4

## Labeling DAPHNET dateset

1. try to do DWT on DAPHNET data with window size of 2s, that is 2*64*9 data for each window

## Preprocessing the datasets and do the labeling as follows:

	* If there is one sampled data in the window is labeled as FoG then it is a FoG
	* The window precede a FoG window is labeled as pre-FoG
	* Everything else is no-FoG
	* no-FoG shrinking to 7/8 as paper indicated



#Day 5 

## Reduce input of neural network
  
  - cut off the high frequency part and leave low frequency part and half the data. 
  - Neural network with input of 64*9, output of 3 classes, FoG, preFoG, no-FoG 
  - Output with softmax function
  - Only one hidden layer
  - How many neurons do we need for each layer? Trains to find the best


## Get the PCA, kernel PCA, LDA, kernel LDA function implementation from Florenc

* Direct PCA on raw data, the first components counts 25 percent of all information, while the others have relatively low and the same amount of information of data. 
* Try to use the first 7 principle components.


#Day6

##CWT
* Clearly more energy is on higher frequency band, the Freez-Index is a good indicator of FoG. Can be an input to NN only if the computation is cheap.

##DWT
* Too much dimensions in one window, 128*9 integers. First use 2 level DWT as low-pass filter. we then have 32*9 integers per window. According to a paper, the interesting things happen around 0-8 Hz, so it is a way to reduce dimension. 

## PCA
* For some patients it is possible to reach high score even at low dimension while some are not(#2 and #7), maybe a good idea to reduce data dimension.

## LDA
* Poor score for a direct LDA.

