typedef unsigned long  uint64_t;
typedef unsigned int   uint32_t;
typedef unsigned short uint16_t;
typedef unsigned char  uint8_t;

typedef signed int   	 sint32_t;
typedef signed short 	 sint16_t;
typedef signed char  	 sint8_t;

/* Write to memory-mapped registers or memory */
#define PUT_UINT32(address, data)  (*((volatile uint32_t *)(address)) = (data))
#define PUT_UINT16(address, data)  (*((volatile uint16_t *)(address)) = (data))
#define PUT_UINT8(address,  data)  (*((volatile uint8_t  *)(address)) = (data))

/* Read from memory-mapped registers or memory */
#define GET_UINT32(address, pData) (*(pData) = *((volatile uint32_t *)(address)))
#define GET_UINT16(address, pData) (*(pData) = *((volatile uint16_t *)(address)))
#define GET_UINT8(address,  pData) (*(pData) = *((volatile uint8_t  *)(address)))

#define ERRORCODE 0x79      
#define DE0_7SEG_DISP			*((volatile uint32_t *)(0xA0004000))

#define I2C_BASE		 			0xA0008000
#define I2C_7SEG_WRITE_ADDRESS	0x40
uint8_t convertDigit(uint8_t num);
void printDisplay(uint16_t number);
uint32_t convert_for_7_seg(uint8_t t1, uint8_t t2);
