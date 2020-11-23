#include <atmega32/asm/io.h>

.global main



main:
    //output for PC0 PC1 PC2
    in r18, DDRC;
    sbr r18,(1<<PC0|1<<PC1|1<<PC2);
    out DDRC, r18;


.loop:

    //turn on PC0, turn off PC2
    //only use a 2 cycle instruction to set bit in PORTC, takes 2 CPU cycles
    cbi PORTC, 2;
    sbi PORTC, 0;

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

    //turn on PC1, turn off PC0
    //only use 2 instructions to set respective bits in PORTC, takes 4 CPU cycles
    cbi PORTC, 0;
    sbi PORTC, 1;

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

    //turn on PC2, turn off PC1
    //only use 2 instructions to set respective bits in PORTC, takes 4 CPU cycles
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


