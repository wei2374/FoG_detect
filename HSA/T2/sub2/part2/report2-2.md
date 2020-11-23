#T2.2
* The current and voltage measures do make sense.Because when compute the DC operating point the capacitance is treated as open circuit, so the voltage is equal to 5V whlie the current through C1 is very small and almost zero.

#T2.3
 According the the graph, the tau measured at the point when Vc equals to 0.632 * 5V = 3.16V, tau equals to 10ms. According to the formula, C equals tau divided by R which is 10K Ohm, the reault is 1 uC which matches the real value.

#R3.1
* H(jw) = Vout/Vin
  Vout is the voltage on capacitor so it's a simple voltage divide equation
  in AC circuit the capacitor has Z=1/jw*C, so we have
  H(jw) = Vout(jw)/Vin(jw) = 1/(jw*C)/(R+1/(jw*C))
  According the the condition we have
  C = 1uF, R = 10 kOhm 
  H(jw) = (1/RC)/(jw+(1/RC)) = 100/(jw+100)

#R3.2
* amptitude |H(jw)| = (1/RC)/sqrt(w^2+(1/RC)^2) = 100/sqrt(w^2+10000)

#R3.3
* Because
  H(jw) = (1/RC)/(jw+(1/RC)) = 100/(jw+100)
  if we multiply (jw-1/RC) with both nominator and denominator we have 
  H(jw) = (1/RC * (jw-1/RC))/(-w^2-1/RC^2)
  According to the formula fai(w) = arg(x+jy) we then have y/x
  w/-(1/RC) = -wRC
  so fai(w) = arctan(-wRC) = arctan(-w*100)

#R3.4
* we try to find the w when |H(jw)| = 0.707
* According to the formula
 100/sqrt(w^2+10000) = 0.707
   w^2+10000 = 20006
   w = 100.03 = 2pi*f
   f = 15.9Hz

#R3.5
* In the ploted graph, when the G(w) is -3dB, the frequency is also 15.9Hz which matches out calculation.

#T4.2
When the resistors decrease to 100k, the crosscurrent increases while the output voltage increases, this is bacause the ratio of resistance of divider resistor and parallel resistance between divider resistor and load resister decreases. So the load resistor get more part of voltage.

#T4.3
* divider current is I_div, load voltage is I_div*R
* current in main branch is I_div*(R+500)/500, voltage on the other resistor is I_div*(R+500)/500
* error is (load_voltage-resistor_voltage)/(U/2)
   
* when the resistors take value 100k Ohm, the voltage measured is 2.27V, divider current is 22.72uA
* when the resistors take value 10k Ohm, the voltage measured is 2.47V, divider current is 247.52uA

* The observation shows that higher divider current leads to higher measured voltage and smaller error.
* This make sense since higher divider current leads to higher load voltage, however, it is in parallel with load resister and need to be always smaller than half of U/2. Increasing I_div helps the load voltage gets closer to U/2.

#T4.4 
* The main drawback of high divider current is too much energy is wasted on resistors since P=I^2 * R.

#T4.6
* The load voltage is very close to 2.5V with the voltage follower and the error is smaller compared to the original setup.

#T4.7
* The crosscurrent can be reduced to very small number by make the resistor value higher. As long as the resistor is reletively very small compare with the input resistance of opamp.

#R4.1
* Advantage: smaller power dissipation. P = I^2 *R. less power generated.
* Disadvantage: more sensitive to noise from outside.
