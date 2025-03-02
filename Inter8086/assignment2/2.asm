DATA    SEGMENT
        BUFFER DB 34H,-3BH,-5AH,72H,0,-2DH,0,66H   
        COUNT EQU $-BUFFER
        RESULT DB 0, 0, 0   
DATA    ENDS

CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        MOV SI, OFFSET BUFFER  
        MOV DI, OFFSET RESULT
        MOV CX, COUNT    
NEXT:	MOV AL, [SI]
		CMP AL, 0H
		JZ ZERO
		JNS POS
		JS NEGE
ZERO:	INC [DI+2]
		JMP FINAL 
POS:	INC [DI]
		JMP FINAL
NEGE:	INC [DI+1]
		JMP FINAL
FINAL:	INC SI
		LOOP NEXT
		MOV AH, 02H
		MOV DL, [DI] 
		ADD DL, 30H
		INT 21H  
		MOV DL, [DI+1]
		ADD DL, 30H
		INT 21H
		MOV DL, [DI+2]
		ADD DL, 30H
		INT 21H
        MOV AX, 4C00H
        INT 21H
CODE    ENDS
        END START