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

//using timer0 to count down
void timer_setup(void)
{
    TCNT0 = 0x00;
    TIFR &= ~(1<<TOV0);
}

int main (void)
{

    USART_Init(0);
    //prescaler to freq/256 = 1M/ 64 =  15625 Hz
    TCCR0 |= (1<<CS00)|(1<<CS01);
    //15625/255 = 61
    unsigned int counter = 0;


    unsigned char msg[]="Hello World!\n";
    while(1)
    {
        for (int i=0;i<13;i++) {

            USART_Transmit(msg[i]);
        }

        //implement a timer for 1 seconds
        //not quite accurate

        //_delay_ms(1000);

          while(counter<61)
        {
            while((TIFR & 0x01)==0) // if the overflow flag is not set yet
            {
                //goes into a loop
            }
             timer_setup();
            counter++;
        }
        counter = 0;



        //reset the timer
    }
    // Should never be reached
    return 0;
}
