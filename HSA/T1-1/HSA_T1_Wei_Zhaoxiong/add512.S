#include <atmega32/asm/io.h>

.global add512

add512:

// ptr to a is in R23:R22
// ptr to b is in R21:R20
// ptr to c is in R25:R24


    //save SREG register
    in r18, SREG;
    push r18;
    //clear c flag and z flag in SREG
    clc;
    clz;

    //save Y register
    push YH;
    push YL;
    //get the value of a
    mov XL,r22;
    mov XH,r23;

    //get the value of b
    mov ZL,R20;
    mov ZH,R21;



    //return value
    mov YL,r24;
    mov YH,r25;
    //st Y+,r18;

    //63 times
    ldi r20,0x40;
1:


    //get the value of a
    ld r18,X+;
    //get the value of b
    ld r19,Z+;

    //add a and b
    adc r18,r19;

    //return value
    st Y+,r18;
    dec r20;

    brne 1b;
    rjmp 1f;

1: nop

    //restore Y register
    pop YL;
    pop YH;

    //restore SREG register
    pop r18;
    out SREG,r18;
    ret

.end


