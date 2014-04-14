#include "main3.h"
#include "i2c.h"

#define DE0_7SEG_DISP *((uint32_t *)(0xA0004000))    // memory address of 7-Segment display on DE0
#define DE0_LEDs *((uint32_t *)(0xA0000000))    // memory address of LEDs on DE0

#define I2C_TEMP_SENSE_Slave_Addr 0x90   // I2C slave address of TMP100 temperature sensor
#define I2C_TEMP_SENSE_Temp_Reg 0x00   // TMP100 Temperature register number = 00h
#define I2C_TEMP_SENSE_Conf_Reg 0x01   // TMP100 Configuration register number = 01h
#define I2C_TEMP_SENSE_12bitRes 0x60   // value to set ADC to 12-bit resolution

int main(void) {  
    uint8_t t1, t2;	
    uint32_t temp;
    sint32_t i;
    
    //Enable I2C controller
    set_clk();	
    
    // 'Clear' 7_Seg display
    DE0_7SEG_DISP = 0xFFFFFFFF;
    
    // configure the I2C temperature sensor with 12-bit resolution
    write_with_start(I2C_TEMP_SENSE_Slave_Addr);
    write_byte(I2C_TEMP_SENSE_Conf_Reg);
    write_with_stop(I2C_TEMP_SENSE_12bitRes);
    
    while (1) {	
        DE0_LEDs = DE0_LEDs|(1<<8);    // blink LED8 to indicate program execution status	
        for (i=0;i<0x300000;i++);      // delay		
	
        // get the temperature sensor value
        write_with_start(I2C_TEMP_SENSE_Slave_Addr);
        write_with_stop(I2C_TEMP_SENSE_Temp_Reg);
        read_with_start(I2C_TEMP_SENSE_Slave_Addr);
        t1 = read_byte();                //Read the higher byte
        t2 = read_with_stop();           //Reading the lower byte
        
        temp = convert_for_7_seg(t1,t2);    // converted the value into appropriate 7-segment format
        DE0_7SEG_DISP = temp;		    // display it on DE0 board
    }
}
