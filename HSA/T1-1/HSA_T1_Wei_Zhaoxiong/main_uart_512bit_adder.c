// get register definitions with auto complete in Qt Creator
#include <atmega32/io.h>

// for delay functions: F_CPU has to be defined
#include <util/delay.h>

// uart library
#include <atmega32/uart.h>



// c = a + b
extern void add512(uint8_t* c, const uint8_t* a, const uint8_t* b);

int main (void)
{
   DDRC  = 0xFF;

   uart_setBaudrateReg(CALC_BAUD_VAL(62500)); // 15
   uart_setFormat();
   uart_enable();

   uint8_t a[64];
   uint8_t b[64];
   uint8_t c[64];

   for(uint8_t i=0; i<64; i++)
   {
       c[i] = 0x00;
   }

   while(1)
   {
       uart_readBlocking((uint8_t*)&a,64);
       uart_readBlocking((uint8_t*)&b,64);

       add512(c,a,b);

       uart_writeBlocking((uint8_t*)&c,64);
   }

   return 0;
}
