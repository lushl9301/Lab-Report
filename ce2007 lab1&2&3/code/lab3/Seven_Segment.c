// functions to convert the 12-bit value into hexadecimal value for the 7-Segment display on DE0
#include "main3.h"
#include "i2c.h"

uint32_t convert_for_7_seg(uint8_t t1, uint8_t t2)
{
	uint32_t data;
	uint32_t temp1, temp2, temp3;
	
	int tt;
	tt = t1;
	//(t1>>4) * 16 + t1&0x0F;
	temp2 = t1 % 10;
	temp1 = (t1 / 10) % 10;
	temp3 = ((t2>>4) * 10 / 16);

	temp1 =convertDigit(temp1);
	temp2 =convertDigit(temp2);
	temp3 =convertDigit(temp3);
	temp1 = temp1<<16;
	temp2 = temp2<<8;
	data = temp1|temp2|temp3;	
	return data;
}

uint8_t convertDigit(uint8_t num) {

	
	uint8_t data;
	
	switch(num) {
		case 0: 
			data = 0x3F;//0011 1111
			break;
		case 1: 
			data = 0x06;//0000 0110
			break;
		case 2: 
			data = 0x5B;//0101 1011
			break;
		case 3: 
			data = 0x4F;//0100 1111
			break;
		case 4: 
			data = 0x66;//0110 0110
			break;
		case 5: 
			data = 0x6D;//0110 1101
			break;
		case 6: 
			data = 0x7D;//0111 1101
			break;
		case 7: 
			data = 0x07;//0000 0111
			break;
		case 8: 
			data = 0x7F;//0111 1111
			break;
		case 9: 
			data = 0x6F;//0110 1111
			break;
		case 10: 
			data = 0x77;//0110 1101
			break;
		case 11: 
			data = 0x7C;//0111 1101
			break;
		case 12: 
			data = 0x39;//0000 0111
			break;
		case 13: 
			data = 0x5E;//0111 1111
			break;
		case 14: 
			data = 0x79;//0110 1111
			break;
		case 15: 
			data = 0x71;//0110 1111
			break;
		default: 
			data = 0x00;//clear
			break;
	}  	
	return data;
}
