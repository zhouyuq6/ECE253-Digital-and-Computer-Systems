			.text
			.global		_start
			
_start:		
		LDR			R1, = LIST			// Points to the elements of the list
		LDR			R2, [R1], #4			// Load number of elements N into R2, -
									// - then move pointer R1 by a word
		MOV			R9, R1				// R9 stores the address of the first element 
									// of the list
		/* Outer loop begins here */
		SUB			R3, R2, #1			// R3 stores the end of the outer loop N-1
		MOV			R4, #0				// R4 is the outer loop counter starting from 0 - C
OUTER:		CMP			R4, R3				// Compare R4 (outer loop counter) and R3 (end of counter)
		BEQ			E_OUTER				// If they are equal, the sorting is done
			
		/* Inner loop begins here */
		SUB			R5, R3, R4			// R5 stores the end of the inner loop N-1-R4 = N-1-C

		MOV			R6, #0				// R6 is the inner loop counter starting from 0
INNER:		CMP			R6, R5				// Compare R6 (inner loop counter) and R5 (end of counter)
		BEQ			E_INNER				// If they are equal, the inner loop is complete
			
									// Now, we load in the numbers into registers and compare, and switch if necessary
		LDR			R7, [R1]			// Adding the contents of R1 into R7, and moving the pointer
		LDR			R8, [R1, #4]			// Adding the contents of R1 into R8
		CMP 		R7, R8					// Compare R7 and R8
		BGT			NO_SWAP				// If R7 > R8, then we do not need to swap
			
		STR			R8, [R1]			// Switching happens: switch - 
		STR			R7, [R1, #4]			// - contents of R7 and R8
			
NO_SWAP:	ADD			R6, #1				// Add one to the inner loop counter
		ADD			R1, #4
		B			INNER				// Branch back to the inner loop
			
E_INNER:	ADD			R4, #1				// Add 1 to the outer loop counter
		MOV			R1, R9				// R1 points to the first element of the list
		B			OUTER				// Back to the outer loop

E_OUTER:	B			E_OUTER

LIST:		.word		10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33
		.end
			
 			