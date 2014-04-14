//************************************************
//   Blink_LED.c CE2007’s Lab #2 sample program
//   This program blinks the LEDs on the DE0 board
//
//************************************************
#include <stdint.h>  // for ISO C99 data type declaration

#define DE0_LEDs *((uint32_t *)(0xA0000000))  // Address of LEDs on DE0 (lowest 10 bits)
#define DE0_SLIDE_SW *((volatile uint32_t *)(0xA0001000)) // Address of slide switches

int main(void) {
    int32_t i;
    while(1) {
        DE0_LEDs = 0x2AA | DE0_SLIDE_SW;  //odd LEDs & slide switch
        for (i=0;i<0x1FFFFF;i++);
        DE0_LEDs=0x155 | DE0_SLIDE_SW;    //even LEDs & slide switch
        for (i=0;i<0x1FFFFF;i++);
    }
}
