#define PRER_LO_OFFSET		0
#define PRER_HI_OFFSET		2
#define CONTROL_OFFSET		4
#define RX_OFFSET   		6
#define TX_OFFSET   		6
#define SR_OFFSET   		8
#define COMMAND_OFFSET   	8

#define I2C_SPEED 		0x63 	/* 100 kHz */

// I2C status register bits
#define I2C_RXACK      (1<<7) // received aknowledge from slave 
#define I2C_BUSY       (1<<6) // bus busy    
#define I2C_ARB_LOST   (1<<5) // arbitration lost bit             
#define I2C_TIP        (1<<1) // transfer in progress    
#define I2C_IRQ        (1<<0) // interrupt pending flag   

// I2C command register bits
#define I2C_START		(1<<7) // start   
#define I2C_STOP		(1<<6) // stop                
#define I2C_READ		(1<<5) // read                
#define I2C_WRITE		(1<<4) // write               
#define I2C_ACK			(1<<3) // ack                
#define I2C_IACK		(1<<0) // interrupt ack         

// I2C control register bits
#define ENABLE			(1<<7) // enable core 
#define INT_ENABLE		(1<<6) // interrupt enable   

void set_clk(void);                        // enable the I2C controller module on DE0
void write_with_start(uint8_t slave_add);  // send address of slave to I2C bus, with a write command
void read_with_start(uint8_t slave_add);   // send address of slave to I2C bus, with a read command
void write_byte(uint8_t byte);             // write one byte to I2C bus
int read_byte(void);                       // read one byte from I2C bus
void write_with_stop(uint8_t byte);        // write one byte to I2C bus, follows by a stop signaling
int read_with_stop(void);                  // read one byte from I2C bus, follows by a stop signalling

void WAIT_FOR_EOT(void);
int  checkACK(void);
