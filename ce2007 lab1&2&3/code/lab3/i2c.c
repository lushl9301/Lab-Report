#include "main3.h"
#include "i2c.h"

void wait_for_eot() // Wait for end of transfer
{
	uint8_t temp;
	do{
		GET_UINT8(I2C_BASE + SR_OFFSET, &temp);
	} while (temp & I2C_TIP);
}

void set_clk() // start the SCL for the I2C controller on DE0
{
	PUT_UINT8(I2C_BASE + CONTROL_OFFSET, ENABLE);
	PUT_UINT16(I2C_BASE + PRER_LO_OFFSET, I2C_SPEED);
	PUT_UINT16(I2C_BASE + PRER_HI_OFFSET, 0x00);
}

int checkACK() {
	uint8_t tmp;
	GET_UINT8(I2C_BASE + SR_OFFSET, &tmp);
	return (tmp & I2C_RXACK);
}

void write_byte(uint8_t byte)
{

	PUT_UINT8(I2C_BASE + TX_OFFSET, byte);					   	// Address High byte
	PUT_UINT8(I2C_BASE + COMMAND_OFFSET, I2C_WRITE);	
	wait_for_eot();
	if (checkACK()) DE0_7SEG_DISP = ERRORCODE;;
}

void write_with_start(uint8_t slave_add)       //send address of slave to I2C bus with a write command
{
	PUT_UINT8(I2C_BASE + TX_OFFSET, slave_add & 0xFE);			        // Writes the Slave address	
	PUT_UINT8(I2C_BASE + COMMAND_OFFSET, I2C_START | I2C_WRITE );		// Sets control register bits	
	wait_for_eot();
	if (checkACK()) DE0_7SEG_DISP = ERRORCODE;
}

void write_with_stop(uint8_t byte)            // send data to slave, follows by a stop signalling
{
	PUT_UINT8(I2C_BASE + TX_OFFSET, byte);							// Writes data to the register
 	PUT_UINT8(I2C_BASE + COMMAND_OFFSET, I2C_WRITE | I2C_STOP );
	wait_for_eot(); 
	if (checkACK()) DE0_7SEG_DISP = ERRORCODE;;
}

void read_with_start(uint8_t slave_add)       //send address of slave to I2C bus with a read command
{
	PUT_UINT8(I2C_BASE + TX_OFFSET, slave_add | 0x01 );
	PUT_UINT8(I2C_BASE + COMMAND_OFFSET, I2C_WRITE | I2C_START);
	wait_for_eot(); 
}

int read_byte()                               // read one byte from I2C bus
{
	uint8_t data;
	PUT_UINT8(I2C_BASE + COMMAND_OFFSET, I2C_READ);
	wait_for_eot();
	GET_UINT8(I2C_BASE + RX_OFFSET, &data );
	return data;
}

int read_with_stop()                         // read one byte from I2C bus follow by a stop signalling
{
	uint8_t data;
	PUT_UINT8(I2C_BASE + COMMAND_OFFSET, I2C_READ | I2C_ACK | I2C_STOP);
	wait_for_eot();
	GET_UINT8(I2C_BASE + RX_OFFSET, &data );
	return data; 
}

