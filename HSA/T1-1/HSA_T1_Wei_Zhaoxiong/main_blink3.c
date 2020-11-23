// Get register definitions with auto complete in Qt Creator
#include <atmega32/io.h>

// For delay functions: F_CPU has to be defined
#include <util/delay.h>


int main (void)
{
    DDRC |= 1<<PC0|1<<PC1|1<<PC2; // Configuring PC Output

    while (1)
     {

         PORTC |= 1<<PC0; // Writing HIGH to PC0
         PORTC &= ~(1<<PC1); // Writing LOW to PC1
         PORTC &= ~(1<<PC2); // Writing LOW to PC2

         _delay_ms(1000); // Delay of 1 Second


         PORTC &= ~(1<<PC0); // Writing LOW to PC0
         PORTC |= 1<<PC1; // Writing HIGH to PC1
         PORTC &= ~(1<<PC2); // Writing LOW to PC2

         _delay_ms(1000); // Delay of 1 Second

         PORTC &= ~(1<<PC0); // Writing LOW to PC0
         PORTC &= ~(1<<PC1); // Writing LOW to PC1
         PORTC |= 1<<PC2 ; // Writing HIGH to PC2

         _delay_ms(100); // Delay of 1 Second

     }


    // Should never be reached
    return 0;
}
