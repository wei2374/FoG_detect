# R2.1
* For hardware PWM generation, a waveform generator hardware is required. It can be find on timer0, timer1 and timer2;
* Timer0 : page 69, one OC0 output, PIN number PB3
* Timer1 : page 87, output OCnA, OCnB, PIN number PD4, PD5
* Timer2 : page 114, output OC2, PIN number PD7

# R2.2
* Fast_PWM use single-slope operation (The counter counts from BOTTOM to MAX then restarts from BOTTOM), it can generates high frequency PWM wave.

* Phase_Correct_PWM on the other hand uses dual-slope operation mode(The counter counts repeatedly from BOTTOM to MAX and then from MAX to BOTTOM.) and twice slower than Fast_PWM. But it offers higher resolution.

# R2.3
* For high precision position control, we need a PWM wave with high resolution, Timer1 has 16-bit so its MAX is 2^16 and higher than Timer0 and Timer2, so the resolution of its PWM is higher. It is more suitable for a precise servo control.

# R2.4
* To generate a 1Hz PWM we need to make the timer count to 256 each second, this means:
1. the timer0 or timer2 using fast pwm need to be schedule as 1M/256 = 3906 which is not possible.

2. the timer0 or timer2 using phase correct pwm need to be schedule as 1M/256/2 = 3906/2 which is not possible.

3. For timer 1 using fast PWM, it would be 1M/2^16 = 15.25, such prescale is not available.

4. For timer 1 using phase correct PWM, it would be 1M/2^16/2 = 7.625, such prescale is close to 8 so it is possible.

We can use the timer1 WGM, using phase correct PWM with 8 prescale.

# R3.1
* The maximum PWM frequency can be found by 1M/256 =3906.25Hz

# R3.2
* The maximum frequency of sine wave can be found be 1M/256/256 = 15.26Hz

# R3.3
* To generate 100Hz sine wave, each PWM need to be finished in 1M/256/100 = 39 cycles. It can not be achieved with timer. So we need to sample data from sine table. It can generate fast PWM frequency but with low precision. We can change the counter from counter++ to counter=counter+20; And the frequency is set as 5Hz.