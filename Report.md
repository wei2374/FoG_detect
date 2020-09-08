
Introduction\
    - About FreezingofGait and researches on it;

Dataset and Observations\
    - DAPHNET dataset and several observations I made on it;
    - The biggest problem is unbalanced data. The number no-FoG data is dominantly larger than FoG data; From my point of view, this may have following problem:
    
        1: Some FoG data maybe wrong labeled as no-FoG data because they are difficult to detected by eye, such miss detection may confuse all models which learns based on dataset.

        2: The characteristic of FoG data is different for different patients. Some are more difficult to detect. A general model is not going to work.
        
    - Bad result with simple machine learning based method. Try to exploit gait features first then LDA.
     
Gait cycle analysis & Data cleaning\
    - Some Gait features I get from observation and how I extract them from patient
    
    - Low-pass filter, 5 order butterworth LP filter, cutoff frequency is 8Hz, sampling frequency is 64Hz, IIR filter
     
    - Step interval; Generally speaking the normal gait interval is around 1s, and the plot result also shows that. We can use auto-correlation in one time window to find the interval since normally there should be two complete step during one time window.
    The peak pos shows the step time interval; This does not suit all axis and sensors; Most effecient when applied to ankle sensors;
    
    - Option one costs too much computation time, algorithm 2 find step depth
    - Also stepdepth can be one feature
    - The difference between threshold and time interval can be another feature
- 

    - Dominant frequency; During normal gait. The dominant feature should be around 1 Hz; it may increase when the FoG causes the paient shaking. This does not suit all axis and sensors; Most effecient when applied to ankle y sensor;

    - Smoothness: used to filter out the period when patient stay silent. This part has generally high frequency components in compare with locomotion band. Should be clean before performing LDA
    
    - Locomotion energy: High during normal gait, low during FoG
    - Freezemotion energy:
    - High band energy

    - FreezingIndex : best indicator of FoG
    - portion above mean : maybe relevant for some patient

  
    - Use some feature as a threshold to filter out some normal gait before actual classify
     
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
