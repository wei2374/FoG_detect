# 1 Accelerometer Calibration
## T1.3 how many parameters do you need for Afit? Please explain.

* Since there is only 90 degrees rotations, each axis of ellipsoid only depends on one axis of coordination system, so non-zero parameter only exists in the diagnal axis of A_fit. There are 3 parameters for A_fit.   
   
## T1.4 What parameters (A, B, . . . , K) of the approximated ellipsoid matrix A˜ become zero? Please explain.

* Since there is only 90 degrees rotations, the ellipsoid can be fully described without D,E and F parameters, since they contribution to the rotations which are not 90 degrees. So we only need tot fit A,B,C,G,H and K; Since they represent the scale on three axis as well as offsets.

## R1.1 How many different poses do we need at least to get a good set of parameters for the implemented calibration algorithm? 

* We need at least 6 different poses to get a set of parameters.
* We need to measure the gravity on x,y and z axis to get different gains.
* For each axis we need the measurement of gravity on both positive and negative axis to get offset


## R1.2 Why should linear accelerations be minimized while capturing data for the calibration? Explain and elaborate.
* The accelerometer is sensitive to linear acceleration.
* In the ideal case, only the gravitational acceleration is present. Any other linear acceleration will generate noise to the calibration.  

## R1.3 How do you minimize linear accelerations?
* The sensor only rotates.
* The measurement start only after it finishes rotating. 
* Reduce vibration as much as possible.

## R1.4 How do you minimize the influence of linear accelerations during calibration?

* If the linear acceleration does not change its direction and magnitude. The influence of linear acceleration is considered as offset in the calibration, it is substracted before rotation.

## R1.5 Describe and explain the mathematical trick we use to get the model matrix M from a properly scaled ellipsoid matrix Afit.

* With A_fit we have formula:
  
    > $(x_{raw}-w)^TA_{fit}(x_{raw}-w)=1$
    
* The method we applied to $A_{fit}$ is called singular value decomposition (SVD). In this method we can use the following formula to express A.
 
*   > $A=U\Sigma V^T$

* $\Sigma$ here is a diagonal matrix, while U and V and unitary rotationary matrix. 
* Since all matrix are stretch and rotation operation in 2D plane. We can understand $A_{fit}$ as first a rotation operation V^T followed by a strech operation $\Sigma$ then end with another rotation matrix U.  

* 
  Since A_fit is a symmetric matrix 
    >$A^T = A$   

    >$U\Sigma V^T=V\Sigma U^T$

    >$U=V$

* We can understand it as first rotate with theta angle, stretch, then rotate back.
 
* We can write the formula as 
    > $(x_{raw}-w)^TA_{fit}(x_{raw}-w)=1$
    
    > $(x_{raw}-w)^TU\Sigma U^T(x_{raw}-w)=1$

* This means, after substacting offset, squaring the raw measurement. We first rotate it then stretch it in different directions, it matches a ellipsoid.

* since we want to get a perfect sphere, we want the strech part as a identity matrix I. So we can modify the A matrix and put the rotation and stretch part into calibration.

   > $(x_{raw}-w)^TU \sqrt{\Sigma} I \sqrt{\Sigma} U^T(x_{raw}-w)=1$

* So we can write $\sqrt{\Sigma}U$ as M, $x_{calib} = M(x_{raw}-w)$.
          
# 2 Magnetometer Calibration         

## R2.1 What are the physical reasons for the distortions we observe in the raw magnetometer measurements?

* Magenetometer has the problem of "hard iron" and "soft iron".
 
* "Hard iron" errors represents the magnetic field which add to the earth's magenetic field. It can be caused by a magnetic material which is close to the sensor ot by current flow nearby. This generates a bias to the measurement.

* "Soft iron" errors represent the magnitude and direction change that the earth’s magnetic field experiences when near ferromagnetic objects. This causes the measured circle streched differently in different directions and distorted into an ellipsoid.

## R2.2 What are soft iron and hard iron effects? Explain and elaborate. 

* Hard iron effects represents the additive magnetic field to the earth's magenetic field. It can be caused by a magnetic material which is close to the sensor or by current flow nearby. As long as th e magnet is static relative to the sensor, it has a constant offsets.

* Soft iron effects represent the earth’s magnetic field is distored by some mateiral which does not necessarily generate a magnetic field itself, and is therefore not additive. It depends on the orientation of object relative to the sensor and therefore not a constant.

## R2.3 For capturing samples for the magnetometer calibration we move the IMU around and samples for as many points on the ellipsoid surface as possible. Why can we do this here while we had to be very careful NOT to move the IMU during the accelerometer calibration?

* The accelerometer measures the acceleration in all directions and can be easily influence by external forces, so we need to be careful not move it(add external force) during the sampling and calibration.
  
* The magnetometer on the other hand cannot be affected by external force and we can move it around which sampling data.

## R2.4 What are the limitations of the magnetometer calibration method we use? 

* We assumes the source of hard iron and soft iron effect does not change during the measurement. However, this is not the caseFor example, when the sensor is mounting to a chip, the current is different for different time.
 
* It is unclear regarding the numerical value of magnetic vector toward ground and north.
 
# 3 Gyroscope Calibration
## R3.1
* Accelerometer can decide roll and pitch angle;
  > $$ roll = arctan(accY/\sqrt(accZ^2+accX^2))

  > $$ pitch = arctan(accX/\sqrt(accZ^2+accY^2))

* gyroscope can decide all three angles by integrating measured rotationary accleration on three axis

  > $$  roll = \int(accX)dt
  
  > $$  pitch = \int(accY)dt

  > $$  yaw = \int(accZ)dt

* magnetomoter can decide yaw angle:
  
  > $$  yaw = arctan(my/mx)

## R3.2
* The drawback of **accelerometer** is that it can be easily influenced by external force and need to be careful during measurement. Any vibration can be a noise to it
* The drawback of **magnetomer** is that is has the problem of hard iron and soft iron, if the source of hard iron effect or soft iron effect moves, it is hard to get rid of these noise
* The drawback of **gyroscope** is it requires integration of measurements and previous error measurement can cumulate to a large error.

## R3.3 What sensor fusion algorithms can be used to improve the estimation of the roll, pitch, yaw angels?   
* Kalman filter.
* Kalman filter has three steps
1. Predict: We can first use the **gyroscope** make a prediction on the next angle based on current angle and acceleration.
2. Measurement: use **accelerometer** and **magnetometer**. 
3. Update: The new angle should be a combnation of Predict state and measurement as correction, in this way the cumulated error in gyroscope can be eliminated.



## R3.4 Is it possible that these fusion algorithms outperform the individual sensors? 
* It is possible. For example, gyroscope may generate culumative error and it can grow to a big number because of integration. The kalman filter can alway make correction to current state with the measurement of magnetometer and accelerometer.
