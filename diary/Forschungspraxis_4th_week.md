#Day2 
* Have a talk with Phillip and he suggests me to try gait cycle analysis.
* Search about gait cycle analysis on the internet and find several papers about extract useful information from accelerometer data.

#Day3
* Study from the paper I searched in the internet about gait cycle analysis and the information we can possible extract from it.

* Step speed, step length, step duration and stride duration: the first two can be extracted with the data of walking distance. Not possible in our case. While the step frequency can be extracted if the accelerometer is located in the middle of body, for example, waist, not possible in our case. 
But I can locate the stride frequency with the help of accelerometer at ankle, the dominant frequency corresponds to it and in the DAPHNET dataset the value is roughly 2.5 Hz in most noFoG labeled period, viable.

#Day4
* If the patient is walking with balance, according to a paper, this can be seen from the proportion of even harmonic and odd harmonic and the accelerometer need to be placed on waist. Not possible for our case.

* According to the same paper, if the patient is walking normally, a smooth walking curve sould be observed in time domain data. That is true since most noFoG data shows smooth curve. I tried to use the sum of neighbour difference in a time period to show the smoothness of walking.

#Day5
* According to the paper of DAPHNET, they use the freezeIndex which is the proportion of (3-8Hz) energy divided by locomotion energy and their matlab code shows a good result. This can also be used as a feature.
