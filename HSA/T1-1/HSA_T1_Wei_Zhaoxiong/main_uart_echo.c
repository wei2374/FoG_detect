// Get register definitions with auto complete in Qt Creator
#include <atmega32/io.h>

// For delay functions: F_CPU has to be defined
#include <util/delay.h>



void USART_Init( unsigned int baud )
{
// This code is used to set Boderate as 62500 according to the formular
UBRRH = 0;
UBRRL = 0;

// Enable receiver and transmitter
UCSRB = (1<<RXEN)|(1<<TXEN);

// Set frame format: 8data, 1 start bit, no parity bit, 1 stop bit
UCSRC = (1<<URSEL)|(3<<UCSZ0);
}

void USART_Transmit( unsigned char data )
{
// Wait until transmit buffer is empty
while ( !( UCSRA & (1<<UDRE)) )
;
// Put data into buffer, sends the data
UDR = data;
}

unsigned char USART_Receive( void )
{
// Wait for data to be received
while ( !(UCSRA & (1<<RXC)) )
;
// Get and return received data from buffer
return UDR;
}



int main (void)
{

    //initialization of UART hardware
    USART_Init(0);
    unsigned char buffer;

    while(1)
    {
           //if receiver something in the buffer
           buffer = USART_Receive();
           // send it back
           USART_Transmit(buffer);
    }

    // Should never be reached
    return 0;
}
