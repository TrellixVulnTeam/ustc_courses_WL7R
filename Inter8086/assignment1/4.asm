DATA	SEGMENT
	A DW 0308H, 0709H
	B DW 0109H, 0509H
	C DW ?, ?
DATA 	ENDS
CODE	SEGMENT
	ASSUME CS:CODE, DS:DATA
START:	MOV AX, DATA
	MOV DS, AX
	MOV SI, OFFSET A
	MOV BX, OFFSET B
	MOV DI, OFFSET C
	INC SI
	INC SI 
	INC BX
	INC BX
	INC DI
	INC DI
	MOV AX, [SI]
	MOV CX, [BX]
	ADD AL, CL
	AAA
	MOV DL, AL
	INC SI
	INC BX
	MOV AX, [SI]
	MOV CX, [BX]
	ADC AL, CL
	AAA
	MOV DH, AL
	MOV [DI], DX
	PUSHF
	SUB DI, 2
	SUB SI, 3
	SUB BX, 3
	POPF
	
	MOV AX, [SI]
	MOV CX, [BX]
	ADC AL, CL
	AAA
	MOV DL, AL
	INC SI
	INC BX
	MOV AX, [SI]
	MOV CX, [BX]
	ADC AL, CL
	AAA
	MOV DH, AL	
	MOV [DI], DX ;FINISH
	MOV DX, [DI]
	AND DX, 0F000H
	ROR DX, 12
	ADD DL, 30H
	MOV AH, 02H
	INT 21H
	MOV DX, [DI]
	AND DX, 0F00H
	ROR DX, 8
	ADD DL, 30H
	MOV AH, 02H
	INT 21H
	MOV DX, [DI]
	AND DX, 00F0H
	ROR DX, 4
	ADD DL, 30H
	MOV AH, 02H
	INT 21H
	MOV DX, [DI]
	AND DX, 000FH
	ADD DL, 30H
	MOV AH, 02H
	INT 21H ;OUTPUT
	
	INC DI
	INC DI
	MOV DX, [DI]
	AND DX, 0F000H
	ROR DX, 12
	ADD DL, 30H
	MOV AH, 02H
	INT 21H
	MOV DX, [DI]
	AND DX, 0F00H
	ROR DX, 8
	ADD DL, 30H
	MOV AH, 02H
	INT 21H
	MOV DX, [DI]
	AND DX, 00F0H
	ROR DX, 4
	ADD DL, 30H
	MOV AH, 02H
	INT 21H
	MOV DX, [DI]
	AND DX, 000FH
	ADD DL, 30H
	MOV AH, 02H
	INT 21H ;OUTPUT
	MOV AX, 4C00H
	INT 21H 
CODE 	ENDS
	END START