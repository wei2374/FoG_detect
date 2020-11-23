# R1.1
According to the data sheet, a normal ADC conversion takes 13 ADC clock cycles, since in T1.1 we prescale the CPU frequency to half. So the ADC conversion takes 26 cycles.

# R1.2
Sampling frequency equals to CPU frequency/(prescale * conversion cycles) = 1Mhz/(2*13) = 38.5kHz 

# R1.3
I think the iteration time of for-loop is limiting the actual frequency.
since the free running start new conversion immediately after the previous conversion completes. And each time when we restart it, the first conversion always costs more than 13 ADC cycles, so it always takes longer time.
# R1.4
3 tau is measured as 68

# R1.5
ADC tick value is selected as 242 since it is 95 percent of 255. The maximum value is 255 and it takes 3 tau time to reach its 95 percent. So 242 is calculated as 255 * 0.95.

# R1.6 
The highest value is 255 and it represents U_ref - 1LSB, the lowest value is 0 and it represents 0 ground.
Since U_ref is 5V, the precision is 8 bit, so 242 equals 242*(5)/256 = 4.73V

# R1.7
according to the formula tau = RC. According to the information each cycle takes 32us, so we can calculate 3RC takes in total 0.002176s. RC is 0.0007. Since we know that R equals to 1k Omh, so we can calculate the capacitance is 0.7uC 

#R1.8
According to the datasheet:
A normal conversion takes 13 ADC clock cycles. The first conversion after the ADC is switched on takes 25 ADC clock cycles.
The actual sample-and-hold takes place 1.5 ADC clock cycles after the start of a normal conversion and 13.5 ADC clock cycles after the start of a first conversion.
So we assume the sample total time takes 14.5 ADC cycles and 29 CPU cycles in our case. The precision is 8 bits. So the frequency should be 8*(1M/29) = 275kHz.  
