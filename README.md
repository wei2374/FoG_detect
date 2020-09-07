# FoG_detect

* Code for data training is found in Folder PYTHON_IM
* Code for GUI is found in Folder L5_Serial_Link_Qt
* Code to be flashed into nRF52 developemnt board is found in Folder ble_app_uart(copy)

since this git folder is only used for keeping track of my research internship, all dataset is not include and path inside the code is not change, you can not run it directly after download.

# GUI

The first step is training the threshold parameters and LDA weights. Use the patient QComboBox to select the patient id, this helps the GUI program to load corresponding data.

Then open the Threshold Tab. Here features for threshold can be selected. The thresholds features are computed according to normal gait and stop gaits. For example, if the Smoothness feature is selected as one threhold feature, then the trainng python script will calculate the smoothness of data during the stop period, normally this would be a quite small value in compare with any motion. So data which smaller than certain value will be filtered out. The slidebar followed can be used to further configure the threshold value, for example, the default value is 500, which means the data is filtered out if its smoothness is smaller than 5 times the smoothness of stop period.

After configuring the thresholds, switch back to LDA tab, here the features for LDA will be selected. Also you can select different classifiers to do the classification. You can also use auto mode to autoconfigure the lda features based on spearman's rank correlation.

Classifiers available are :
> 1. Decision tree using new metrics 
> 2. Decision tree using scaled gini index

After the configuration, we can click the train button to call python program (python2.7) to train relevant parameters using dataset. After the training process is finished, it returns and informs the user and save results into a file at the same time. 
   
Then user can further use GUI to send results of training and raw data measurement in window form to hardware with UART, the hardware returns the detection result back to user interface before it receives new window.

The procedure of using it is 
1. Configuration
2. Train
3. Read parameters
4. Send parameters
5. Send Data

# Python code

> Read parameters from UI
> Feature extraction

> Feature selection using spearman's rank correlation

> LDA 

> Decision tree using classifier 1 and 2

> Write into file

# C code

* The board is able to receive command using nRF connect app in smartphone and start to receive parameters and data.
* Receive parameters and data from UART, performs feature extraction and FoG detection. Returns result back to PC.

* TODO:: sample entropy calculation
* TODO:: Receive result from board 