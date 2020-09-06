#Day1
* Try to use neural network to classify with gait features.
* Extract some gait features from dataset, they are domiant frequncy(stride freqquency), freezeIndex, mean value, sum of difference between neighbour points and proportion of data which is greater than mean of vertical ankle accelerometer.   
* Only with the data of patient 1, window size is 4 second, step is 1 second, with the input of gait features.

* The neural network cannot classify correctly, all FoG data is classified as noFoG data.

* According to my observation, first of all the dataset is highly unbalanced, 2700 noFoG data with 170 FoG data. Besides, if the relationship between FoG and frequency components is correct some data are wrong labeled in the first patient, labeled time is earier or late for 1 or 2 seconds, so the noFoG data accutally compromise some FoG data, so the neural network cannot do the classification.


#Day2
* Try to use simple threshold method as the paper of DAPHNET, which achieving 90 percent accuracy and specificity. Adding some of my gait features with some self defined threshold, less false positive is made by the classifier but more false negative is made, but overall wrong classification is less.

#Day3
* Plot the data of some gait features, the data seems to be separable.
* Try to includes more data of knee accelermeters and do PCA before projected.
