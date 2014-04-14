#include "main3.h"
#include "i2c.h"

#define I2C_7SEG_Slave_Addr 0x40

int main(void) {  
    uint8_t countUp;
    uint32_t i;
    uint8_t code[] = {0x53, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};
    
    set_clk();  //Enable I2C - see i2c.c for detail
    while (1) {
        for(countUp = 0; countUp < 10; countUp++) {
            // Output a single digit to the I2C based 7-Seg display on the TAB 
            write_with_start(I2C_7SEG_Slave_Addr);
            // Output the address of the slave device: the 7-SEG display
            write_with_stop(code[countUp]);
            // output the single byte data to be displayed
            for(i = 0; i < 5000000; i++);//delay
        }
    }
}
