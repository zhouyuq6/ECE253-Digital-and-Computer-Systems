	.include "address_map_arm.s"
/* 
 * This program demonstrates the use of interrupts using the KEY and timer ports. It
 * 	1. displays a sweeping red light on LEDR, which moves left and right
 * 	2. stops/starts the sweeping motion if KEY3 is pressed
 * Both the timer and KEYs are handled via interrupts
*/
			.text
			.global	_start
_start:
			/*initialize the IRQ stack pointer*/
			MOV	R0,#0b10010	//ISR_MODE
			MSR	CPSR,R0
			LDR	SP,=0x20000	//set up SP
			/*initialize the SVC stack pointer*/
			MOV	R0,#0b10011	//SVC_MODE
			MSR CPSR,R0
			LDR	SP,=0x3FFFFFFC
			
			BL	CONFIG_GIC			// configure the ARM generic interrupt controller
			BL	CONFIG_PRIV_TIMER	// configure the MPCore private timer
			BL	CONFIG_KEYS			// configure the pushbutton KEYs
			
			/*enable ARM processor interrupts*/
			MSR	CPSR,#0b00010011
			LDR	R6, =0xFF200000 		// red LED base address
MAIN:
			LDR	R4, LEDR_PATTERN		// LEDR pattern; modified by timer ISR
			STR R4, [R6] 				// write to red LEDs
			B 	MAIN

/* Configure the MPCore private timer to create interrupts every 1/10 second */
CONFIG_PRIV_TIMER:
			LDR	R0, =0xFFFEC600 // Timer base address
			LDR	R1, =20000000	//
			STR	R1,[R0]
			MOV	R2,#0b111		// A=1,E=1,I=1
			STR	R2,[R0,#8]
			MOV	PC, LR			// return

/* Configure the KEYS to generate an interrupt */
CONFIG_KEYS:
			LDR R0, =0xFF200050	// KEYs base address
			LDR	R3, =0b1000		//KEY3 is pressed
			STR R3, [R0, #8]
			MOV PC, LR 			// return

			.global	LEDR_DIRECTION
LEDR_DIRECTION:
			.word 	0							// 0 means left, 1 means right

			.global	LEDR_PATTERN
LEDR_PATTERN:
			.word 	0x1
