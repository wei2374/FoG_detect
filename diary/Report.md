
Introduction\
    - About FreezingofGait and researches on it;
    - Rhythmic auditory stimulation (RAS), context-aware
    - algorithms to detect FOG online and provide RAS;
    - Threshold between standing and other states, total energy content is lower

Dataset and Observations\
    - DAPHNET dataset and several observations I made on it;
    - The biggest problem is unbalanced dataset. The number no-FoG data is dominantly larger than FoG data; From my point of view, this may have following problem:
    
        1: Some FoG data maybe wrong labeled as no-FoG data maybe because they are difficult to detected by eye, such miss detection may confuse all models which learns based on dataset.

        2: The characteristic of FoG data is different for different patients. Some are more difficult to detect. A general model is not going to work.
        
    - Bad result with simple machine learning based method. Try to exploit gait features first then LDA.
     
Gait cycle analysis & Data cleaning\
    - Some Gait features I get from observation and how I extract them from patient
    
    
### - Observation: A normal walking pattern shows periodicity, mwthods to extract this feature

    1. Sample Entropy : A measure of complexity, Often used to analyse the physiological variability in human gait. A feature which shows the repeatability and predictability within one window. In this study the dimension m is selected as 2, r = 0.2*standard deviation.
    * Formula
    * Graph
     
<img src="/home/wei/Documents/Forschung/DAPHNET/dataset_fog_release/scripts/pictures
/sample_entropy_s2_p2.png" style="width:800px;height:300px;"/>


    1. Step interval : (Low-pass filter, 5 order butterworth LP filter, cutoff frequency is 8Hz, sampling frequency is 64Hz, IIR filter)

       - 1. Auto-correlation : Generally speaking the normal gait interval is around 1s, and the plot result also shows that. We can use auto-correlation in one time window to find the interval since normally there should be two complete step during one time window. The peak pos shows the step time interval; But it is computational very expensive. 
        * The correlation can be another feature.
       
       - 2. Use step-depth to detect one step, observing the data from time domain, we find that a normal gait generally has a deep descent. As the following figure shows; However in the FoG phase, this step depth disappear. A cheap algorithm can be applied to find the distance between two such descent and yields the step interval. The descent depth threshold is adaptive for all patient, it is calculated as 0.55 normal gait step depth. 
         * Also the step depth can be another feature.   

 
    2. portion above mean : maybe relevant for some patient

### - Frequency Information

    
    
    - Option one costs too much computation time, algorithm 2 find step depth
    - Also stepdepth can be one feature
    - The difference between threshold and time interval can be another feature

    - Dominant frequency; During normal gait. The dominant feature should be around 1 Hz; it may increase when the FoG causes the paient shaking. This does not suit all axis and sensors; Most effecient when applied to ankle y sensor;

    - Smoothness: used to filter out the period when patient stay silent. This part has generally high frequency components in compare with locomotion band. Should be clean before performing LDA
    
    - Locomotion energy: High during normal gait, low during FoG
    - Freezemotion energy:
    - High band energy

    - FreezingIndex : best indicator of FoG,s. FI has been widely used to detect
    freezing events because it reflects the high–frequency compo-
    nents in the freeze band related to trembling of the lower limb
    that are not apparent when standing or walking.

### Observation: the feature does not select FoG equally well for sensors in different position and in different axis

LDA using features
    - Some features I selected for classifying and LDA method
    - Classifiers
  - 
        - Gini index classifier : very aggresive, makes lots of false alarm
        - Gini index classifier with weights: less aggresive
        - classifier : 
  

New Evaluation Standard
    - Not a simple pattern recognition problem.
    - Important is to cover as much FoG period as possible, and make less false alarm 

Comparison with original method
    - Make a comparision with original DAPHNET paper using new evaluation standard

Hardware implementation
    - GUI design
    - board implementation with nRF52
    - matlab code
    - python code

Contribution and future improvements
    - Framework which combines threshold data-cleaning and LDA, tuning parameters to get good results.
    - Try more gait features 
    - Using different features for LDA or threshold for different patient
