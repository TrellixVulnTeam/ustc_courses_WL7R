DATA    SEGMENT 
		BUFF DB "I am HUANGzp", "$"
		COUNT EQU $-BUFF
DATA    ENDS

CODE    SEGMENT 
MAIN	PROC FAR
        ASSUME CS:CODE,DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        MOV SI, OFFSET BUFF 
        MOV CX, COUNT
AGAIN:	MOV AL, [SI]
		CALL TOLA
		MOV [SI], AL
		INC SI
		LOOP AGAIN 
		MOV AH, 09H
		MOV DX, OFFSET BUFF
		INT 21H
		MOV AX, 4C00H
		INT 21H
MAIN	ENDP
        
;��������ж�AL�����ASIIC�ַ��Ƿ���Сд�ַ�,�����Сд�������ĳɴ�д
;ʹ���˼Ĵ���:AL
;���:AL		����:AL 
TOLA	PROC FR
		PUSHF
		CMP AL, 'a'
		JL FINAL
		CMP AL, 'z'
		JG FINAL
		SUB AL, 20H
FINAL:	POPF
		RET
TOLA	ENDP 

CODE	ENDS
		END MAIN
		