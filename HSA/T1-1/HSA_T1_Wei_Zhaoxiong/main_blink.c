// Get register definitions with auto complete in Qt Creator
#include <atmega32/io.h>

// For delay functions: F_CPU has to be defined
#include <util/delay.h>


int main (void)
{
    DDRC |= 1<<PC0; // Configuring PC0 as Output
     while (1)
     {
         PORTC |= 1<<PC0; // Writing HIGH to PC0
         _delay_ms(1000); // Delay of 1 Second
         PORTC &= ~(1<<PC0); // Writing LOW to PC0
         _delay_ms(1000); // Delay of 1 Second
     }

    return 0;
}
