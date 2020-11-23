#include <atmega32/asm/io.h>

.global main



main:

    //output for PC3
    in r18, DDRC;
    sbr r18,(1<<PC3);
    out DDRC, r18;


    //input for PC4
    in r18, DDRC;
    cbr r18,(1<<PC4);
    out DDRC, r18;

loop:

    sbic PINC,PC4;
    rjmp high;//if PIN4 is high, jump to high branch

    //wait for one second

        ldi r18, 0x3F;
        ldi r24, 0x0D;
        ldi r25, 0x03;
    1:
        subi r18, 0x01;
        sbci r24, 0x00;
        sbci r25, 0x00;
        brne 1b;
        rjmp 1f;
    1:

        cbi PORTC, PC3;//set PC3 to low
        rjmp end;

high:

    //wait for one second

        ldi r18, 0x3F;
        ldi r24, 0x0D;
        ldi r25, 0x03;
    2:
        subi r18, 0x01;
        sbci r24, 0x00;
        sbci r25, 0x00;
        brne 2b;
        rjmp 2f;
    2:
        sbi PORTC, PC3;
        //set PC3 to high

end: rjmp loop;

    ret                         ; exit, should never be reached

.end


