// Get register definitions with auto complete in Qt Creator
#include <atmega32/io.h>

// For delay functions: F_CPU has to be defined
#include <util/delay.h>

// uart library
#include <atmega32/uart.h>

void init_adc()
{
    //configure AVCC 5V as AREF
    ADMUX |= (1<<REFS0);
    //prescaler of 2, give 500Hz,ADPS0=ADPS1=ADPS2=0
    ADCSRA &= ~(1<<ADPS0)&~(1<<ADPS1)&~(1<<ADPS2);
    //free running mode, ADTS0=ADTS1=ADTS2=0
    SFIOR &= ~(1<<ADTS0)&~(1<<ADTS1)&~(1<<ADTS2);
    //8 bit precision, left adjusted
    ADMUX |= (1<<ADLAR);
    //enable ADC
    ADCSRA |= (1<<ADEN);
}

void adc_readBlocking(uint8_t* b,uint8_t ch)
{
    //channel mapping to ADMUX
    //clear last 3 bits;
    ADMUX &= (0xF8);
    ADMUX |= ch;

    //start ADC
    ADCSRA |= (1<<ADSC);

    //if ADSC if 0 again, means conversion finishes, restart it.
    while ( ADCSRA & (1<<ADSC) )
    {}

    //return high 8 bits;
    *b =  ADCH;
}

int main (void)
{
    init_adc();
    uint8_t selected_pin = 2;
    uint8_t result_value = 0;
    while(1)
    {
        adc_readBlocking(&result_value,selected_pin);
        uart_writeBlocking((uint8_t*)&result_value,1);
        _delay_ms(1000);
    }
    // Should never be reached

    return 0;
}
