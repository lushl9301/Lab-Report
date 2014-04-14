#include <stdint.h>  // for ISO C99

#define DE0_SLIDE_SW *((volatile uint32_t *)(0xA0001000))  // address of Slide switc
#define DE0_7SEG_DISP *((uint32_t *)(0xA0004000))  // address of 7-Segment display
#define DE0_LEDs *((uint32_t *)(0xA0000000))  // address of LEDs

// Look-up table for 7-Segment display - Nth index gives code to display N on seven segment display
uint8_t sevenSegCode[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

int main(void) {
    uint8_t numA, numB;
    int32_t i;
    DE0_LEDs = 0x0;          // turn off all LEDs  
    while (1) {
        // Get two 2-bit numbers from slide switch (bits 0 & 1, bits 2 & 3)
        numA = DE0_SLIDE_SW & 0x03;         // bit 0 and 1 of slide switch
        numB = (DE0_SLIDE_SW & 0x0C) >> 2;  // bit 2 and 3 of slide switch 
        
        // Display the two numbers and their sum on the 7-Seg display
        DE0_7SEG_DISP = (sevenSegCode[numA + numB])+(sevenSegCode[numA]<<16)+(sevenSegCode[numB]<<24);	
        
        DE0_LEDs = DE0_LEDs^(1<<8);    // blink LED8 to indicate program execution status
        for (i=0;i<0x1FFFFF;i++);      // delay
    }
}
