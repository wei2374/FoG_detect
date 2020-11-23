// Get register definitions with auto complete in Qt Creator
#include <atmega32/io.h>

// For delay functions: F_CPU has to be defined
#include <util/delay.h>


int main (void)
{
    DDRC |= 1<<PC3; // Configuring PC3 as Output
    DDRC &= ~(1<<PC4); // Configuring PC4 as Input

     while (1)
     {
         if(PINC & (1<<PC4)) // detect PC4
         {
             _delay_ms(1000); // Delay of 1 Second
             PORTC |= (1<<PC3); // Writing HIGH to PC3
         }

         else
         {
             _delay_ms(1000); // Delay of 1 Second
             PORTC &= ~(1<<PC3); // Writing LOW to PC3
         }

     }

    // Should never be reached
    return 0;
}
