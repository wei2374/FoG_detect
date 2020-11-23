#include <atmega32/asm/io.h>

.global main

main:

    //output for PC0
    in r18, DDRC;
    sbr r18,(1<<PC0);
    out DDRC, r18;

    //set PC0 to one
    in r18,PORTC;
    cbr r18,(1<<PC0);
    out PORTC,r18;

.loop:

    cbi PORTC, 0;
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
1: nop

    sbi PORTC, 0;

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

2: nop;

rjmp .loop;




    ret                         ; exit, should never be reached

.end


