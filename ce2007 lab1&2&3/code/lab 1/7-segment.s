; Blink_LED.s   Lab #1 sample program
; This program blink the LEDs on the DE0 board

; Stack related directives
		AREA	STACK, NOINIT, READWRITE, ALIGN=4	; Name this block of code as STACK, reside in the RAM area
Stack_Size	EQU	0x200					; Stack Size = 0x200 bytes
Stack_Mem	SPACE	Stack_Size				; Reserve the space in RAM
TOP_STACK							; Set top of stack location

; Vector Table - link to Address 0 at Reset
		AREA	RESET, DATA, READONLY			; Name this block of code as RESET, reside in the ROM area
__Vectors	DCD	TOP_STACK		   			; Vector table start here, first enty is the 'Top of stack'
		DCD	START					; second entry is the Reset vector address

; User Application
	AREA	texts, CODE, READONLY	 			; Name this block of code as texts, reside in the ROM area
ENTRY					   					; Mark first instruction to execute
START   	PROC						; Declaration of subroutine/function 
		MOVS	R2,#0xA						; Store address 0xA0000000 in R2; start with 0xA
		LSLS	R2,R2,#16
		ADDS	R2,#0x04
		LSLS 	R2,R2,#12						; Logical left shift R2 to obtain the correct address0xA0000000
			
		MOVS	R5,#0xA
		LSLS	R5,R5,#16
		ADDS	R5,#0x01
		LSLS	R5,R5,#12
		MOVS	R1,#0x00

leds_on		LDR	R6,[R5]

		MOVS	R0,#0x01 			;1
		MOVS	R1,#0x06
		SUBS	R0,R6,R0
		BEQ	display

		MOVS	R0,#0x02 			;2
		MOVS	R1,#0x5B
		SUBS	R0,R6,R0
		BEQ	display

		MOVS	R0,#0x04 			;3
		MOVS	R1,#0x4F
		SUBS	R0,R6,R0
		BEQ	display

		MOVS	R0,#0x08			;4
		MOVS	R1,#0x66
		SUBS	R0,R6,R0
		BEQ	display

		MOVS	R0,#0x10			;5
		MOVS	R1,#0x6D
		SUBS	R0,R6,R0
		BEQ	display

		MOVS	R0,#0x20			;6
		MOVS	R1,#0x7D
		SUBS	R0,R6,R0
		BEQ	display

		MOVS	R0,#0x40		 	;7
		MOVS	R1,#0x07
		SUBS	R0,R6,R0
		BEQ	display

		MOVS	R0,#0x80		 	;8
		MOVS	R1,#0x7F
		SUBS	R0,R6,R0
		BEQ	display

		MOVS	R0,#0x10 			;9
		LSLS	R0,#4			 	
		MOVS	R1,#0x6F
		SUBS	R0,R6,R0
		BEQ	display

		MOVS	R1,#0x3F			;0

display		STRH	R1,[R2]					; Store the value to the DE0_LED address
		B	leds_on				 	; Repeat
		ENDP								; END of this subroutine

; The following codes are not used in this application, but their symbols are required for error-free linking by default linker setup	
	EXPORT	__Vectors				; default symbol required by the linker, not used in this program
	EXPORT	Reset_Handler   				; default symbol required by linker, not needed in this program
				
	AREA	texts, CODE, READONLY, ALIGN=4
Reset_Handler	PROC					; Typical code for Reset_vector handler
		LDR	R0, =START			; User Application called by Label
		BX	R0
		ENDP
	END						; End of code. Assembler ignore code beyind this point
