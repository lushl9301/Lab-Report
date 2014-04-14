//************************************************
//   Blink_LED.c CE2007’s Lab #2 sample program
//   This program blinks the LEDs on the DE0 board
//
//************************************************
#include <stdint.h>  // for ISO C99 data type declaration

#define DE0_LEDs *((uint32_t *)(0xA0000000))  // Address of LEDs on DE0 (lowest 10 bits)

int main(void) { 
    int32_t i;	
    while (1) {
        DE0_LEDs=0x3FF;                   // turn on all LEDs 
        for (i=0;i<0x1FFFFF;i++);         // delay	
        DE0_LEDs=0x000;                   // turn off all LEDs
        for (i=0;i<0x1FFFFF;i++);         // delay
    }
}
