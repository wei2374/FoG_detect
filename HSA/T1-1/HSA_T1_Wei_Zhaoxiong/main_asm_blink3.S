#include <atmega32/asm/io.h>

.global main



main:
    //output for PC0 PC1 PC2
    in r18, DDRC;
    sbr r18,(1<<PC0|1<<PC1|1<<PC2);
    out DDRC, r18;


.loop:

    //turn on PC0, turn off PC1 and PC2
    sbi PORTC, 0;
    cbi PORTC, 1;
    cbi PORTC, 2;

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
    1:nop;

    //turn on PC1, turn off PC0 and PC2
    cbi PORTC, 0;
    sbi PORTC, 1;
    cbi PORTC, 2;

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
    2:nop;

    //turn on PC2, turn off PC0 and PC1
    cbi PORTC, 0;
    cbi PORTC, 1;
    sbi PORTC, 2;

    //wait for one second

    ldi r18, 0x3F;
    ldi r24, 0x0D;
    ldi r25, 0x03;
    3:
    subi r18, 0x01;
    sbci r24, 0x00;
    sbci r25, 0x00;
    brne 3b;
    rjmp 3f;
    3:nop;



rjmp .loop;




    ret                         ; exit, should never be reached

.end


