#include <atmega32/io.h>

#include <atmega32/uart.h>
#include <atmega32/adc.h>

#include <util/delay.h>


int main (void)
{            
    DDRC  = 0xFF;

    uart_setBaudrateReg(CALC_BAUD_VAL(62500));
    uart_setFormat();
    uart_enable();

    //prescaler of 2, give 500Hz,ADPS0=ADPS1=ADPS2=0
    ADCSRA &= ~(1<<ADPS0)&~(1<<ADPS1)&~(1<<ADPS2);

    adc_setStdConfig();
    adc_enable();



    uint8_t val[1024];
    int i=0;
    while(1)
    {


        if(i<512)
        {
            //PC1 set as output to charge capacitor
            PORTC |= (1 << PC1);

            //_delay_ms(1);

            //read adc value of ADC0
            adc_readBlocking(&val[i],0);
        }
        else
        {

            //PC1 set as output to charge capacitor
            PORTC &= (0 << PC1);

            //_delay_ms(1);
            //read adc value of ADC0
            adc_readBlocking(&val[i],0);
        }
        i++;
        if(i==1024) {
            i=0;

            uart_writeBlocking((uint8_t*)&val[0],255);
            uart_writeBlocking((uint8_t*)&val[255],255);
            uart_writeBlocking((uint8_t*)&val[510],255);
            uart_writeBlocking((uint8_t*)&val[765],255);
            uart_writeBlocking((uint8_t*)&val[1020],4);



            //break;
        }


    }

    return 0;
}
