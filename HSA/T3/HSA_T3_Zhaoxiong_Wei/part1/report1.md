# T1.2
* To set the blink freqency as 0.5Hz, we can toggle the output every 1 second. Since the prescale is 64, we should toggle for every 1M/64/256 = 61 timer interrupt.

# R1.1
1. Interrupt : The program stop what it is doing right now and jumps to do some other service, after it finishes the interupt service, it goes back to where it stop in main branch and continue its work.

2. Interrupt service routine : A piece of code which will be executed when interrupt happens
 
3. Busy waiting state : A state which the CPU executing some code which do nothing but to kill the time. 

# R1.2
* Busy waiting state is purely software realized. When the CPU is in a busy waiting state, it should always stay awake and it is not power effecient. Also busy waiting stops the CPU from doing other meaningful stuff.

* Compare with it, the interrupt is hardware-supported. The CPU can put it self into a low power mode and the interrupt wakes it up whenever necessary. Also the CPU can execute some other code instead of just waiting for something to happen.
# R1.3
According to the datasheet, there are following situations:
1. If the corresponding interrupt enable bit is not enabled or the nested interrupt bit is not enabled, the interrupt will not be executed until the enable bit is set.
2. If the nested interrupt bit is set and interrupt enable flag is set. When the interrupt has a higher priority, it will break the execution of current interrupt and executes its code. If its priority is lower, it will wait until current ISR finishes.
The priority of Interrupts can be find in page 44 of datasheet.
The relevant page is page 14 and 44 of datasheet.

# R1.4
* According to the datasheet, the address of Interrupt vector of INT0 is lower than address for TIMER2 OVF, thus it has higher priority, so it is able to interrupt the ISR of TIMER2 OVF.

# R1.5
* If an ISR takes too much time it stops other code from executing, either main branch or other ISR code. Also in the case of timer, the counting may not be correct if the ISR is taking too much time. It is not possible to interrupt the same interrupt, since it has same priority.

# R1.6
* The time we want to have is interrupt every second and toggle pc0 output value. So the CPU can count 1M ticks. What we have here is value*(1M/prescalar/256) = 1M; The value should set as an integer. Ideally the smaller the prescaler, the larger the value and the more accurate the result. So we should choose the prescalar to 1 and then we have value as 3906.

# T2.2
Generally speaking when the duty cycle is small most of time the light is off, when the duty cycle is large most of the time the light is on;

When the value of the duty cycle gets close to a minimum, the light is on sometimes for quite a long time. 

Such issue is because the ADC change the value of OCR0 at wring time. Change the OCR0 when a cycle ends solves this issue.

# R2.1
TIMER0, TIMER1 and TIMER2 can be used to generate PWM since all of them have compare match ISR.
reference page number 44;
# R2.2
* According to my observation, the maximum value of duty cycle is 1 when the ADC is 255 ,and the minimum value is 0 when the ADC is 0.

# R2.3
* There are two place in memory where the same value is safed in double-buffering. In our case of PWM generation, the value of OCR register is saved in two buffers. This synchronize the update of OCR compare register to either top or bottom of counting sequence and making the output glitch-free.
 