# T5.4
When the maximum simulation time step is 1us, the plot near each amplitude is more smooth while the curve is less smooth when the maximum stimulation time step is 20us.

# T5.5
The volatage of Vb changes acoording to the change of force applied to it according to the observation. To measure the diatance change, we need to integrate the acceleration and it will not be accurate.
The variation of voltage is too small to be direct measured by the ADC of AVR, an amplification is required.

#T5.7
* When the bias voltage is 2.5V, the output voltage measured is correctly amplified for both positive and negative value, and the bias of the AC voltage output is 2.5V.

* When the bias voltage is 0V, the bias voltage is 0V, the positive part of circuit is correctly amplified but the negative part is satisfied to 0.

* This is because the output voltage of the opamp is between 0-5V, so the negative part is satisfied at 0 in the second case.

# T5.9
50Hz and its harmonic 100Hz should be the power line noise, because the utility frequency is normally 50Hz and 60Hz. 
1K Hz should be the noise of actuator.

# T5.10
According to the datasheet, the amptitude gain of the opamp decreases with increasing frequency, so the original signal with 5Hz is amplified most, the 1k Hz signal is amplified least.

# T5.12
It can be observed that thte output of op-amp is more smooth since the 1k Hz frequenct noise is filtered.
