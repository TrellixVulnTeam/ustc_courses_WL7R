CS0 EQU 3000H ;ƬѡCS0 ��Ӧ�Ķ˿�ʼ��ַ
MY8255_A EQU CS0+00H ;8255 ��A �ڵ�ַ
MY8255_B EQU CS0+01H ;8255 ��B �ڵ�ַ
MY8255_C EQU CS0+02H ;8255 ��C �ڵ�ַ  
MY8255_MODE EQU CS0+03H ;8255 �Ŀ��ƼĴ�����ַ    

CS2 EQU 3040H ;ƬѡCS2 ��Ӧ��8254�˿�ʼ��ַ
MY8254_COUNT0 EQU CS2+00H ;8254 ������0 �˿ڵ�ַ
MY8254_MODE EQU CS2+03H ;8254 ���ƼĴ����˿ڵ�ַ  

;��8259 IRQ8-15��IRQ10 ʵ��ƽ̨IR1 
;72H *4 = 01C8H��01CBH
IRQ_IVADD EQU 01C8H ;irq10��Ӧ���ж�������ַ
IRQ_OCW1 EQU 0A1H
IRQ_OCW2 EQU 0A0H 
IRQ_IM EQU 0FBH     ;irq10��Ӧ��IMR    

DATA SEGMENT 
	TIME DB 11H, 59H, 59H  
	SHOW DB 00H, 00H, 00H, 00H, 00H, 00H
	BUFF DB 00H, 10H, 20H, 30H, 40H, 50H, 60H, 70H, 80H, 90H;TODO 
	STRING DB "full hour", "$"
DATA ENDS

CODE SEGMENT
		ASSUME CS:CODE
START:	MOV AX, DATA
		MOV DS, AX
		MOV SI, OFFSET TIME
		CLI ;���ж�
		;����ԭ�����ж�����
		MOV AX, 0000H
		MOV ES, AX
		MOV DI, IRQ_IVADD 
		MOV AX, ES:[DI]  ;IP
		PUSH AX
		MOV AX, ES:[DI+2]  ;CS
		PUSH AX  
		
		;�����ж�����       
		MOV AX, SEG MYINT
		MOV ES:[DI+2], AX
		MOV AX, OFFSET MYINT
		MOV ES:[DI], AX
		
		CALL INIT_8255
		CALL INIT_8259
		CALL INIT_8254
		MOV AX, 0
		MOV BX, 0
		MOV DX, 0
		STI
AGAIN:	MOV CX, 100 
		INT 72H
		LOOP AGAIN 
		MOV AX, 4C00H
		INT 21H 
		
		
INIT_8259 PROC NEAR
		MOV AL, 00010011B
		OUT IRQ_OCW2, AL
		MOV AL, 01110000B
		OUT IRQ_OCW1, AL
		MOV AL, 00000001B
		OUT IRQ_OCW1, AL  
		
		MOV AL, IRQ_IM
		OUT IRQ_OCW1, AL;
		RET
ENDP INIT_8259
		
INIT_8255 PROC NEAR
		MOV DX, MY8255_MODE
		MOV AL, 10000000B ;��ʽ0��A��B�����
		OUT DX, AL
		RET
ENDP INIT_8255

INIT_8254 PROC NEAR
		MOV DX, MY8254_MODE          ;��ʼ��8253������ʽ
        MOV AL,34H                  ;������0����ʽ2
        OUT DX,AL
                
        MOV DX, MY8254_COUNT0        ;װ�������ֵ
        MOV AL,00H                 
        OUT DX,AL 
        MOV AL,48H                  ;18.432k��Ƶ
        OUT DX,AL 
		RET
ENDP INIT_8254


		
MYINT PROC FAR
		;TODO
		PUSHF 
		PUSH DX
		PUSH SI
		PUSH DI
		PUSH CX 
		MOV AL, [SI+2]
		INC AL
		DAA
		MOV [SI+2], AL
		CMP AL, 60H
		JNZ NEXT
		MOV [SI+2], 00H 
		MOV AL, [SI+1]
		INC AL
		DAA
		MOV [SI+1], AL
		CMP AL, 60H
		JNZ NEXT 
		MOV [SI+1], 00H  
		;���㱨ʱ
		MOV AH, 09H
		MOV DX, OFFSET STRING
		INT 21H 
		
		MOV AL, [SI]
		INC AL
		DAA
		MOV [SI], AL
		CMP AL, 12H
		JNZ NEXT
		MOV [SI], 00H 
   
		
NEXT:	MOV DI, OFFSET SHOW
		ADD DI, 5
		ADD SI, 2 
		MOV CX, 3
L1:		MOV AL, [SI] 
		AND AL, 0FH
		MOV BX, OFFSET BUFF
		XLAT
		MOV [DI], AL
		DEC DI
		MOV AL, [SI] 
		AND AL, 0F0H
		ROR AL, 4   
		XLAT
		MOV [DI], AL
		DEC DI
		DEC SI
		LOOP L1
		
 
		MOV CX, 6
        ;MOV DI,0000H 
        MOV DI, 0005H
        MOV BH,0DFH  ;ѡͨ��6�������
A:		;MOV AL,SHOW[DI] ;����DI��Ӧ��ʱ��
        ;MOV AH,0
        ;MOV SI,AX
        MOV AL,BH
        MOV DX,MY8255_A 
        ;OUT DX,AL 
        OUT DX, AL  
        MOV AL,SHOW[DI] ;ʱ������Ӧ������ܱ�
        MOV DX,MY8255_B
        OUT DX,AL   
        ;CALL DELAY
        DEC DI
        ROR BH,1 ;����һλʹ֮ѡͨ��һ���������
        ;CMP DI,06H ;DIΪ6˵��һ����ʾ����
        ;JNE A ;δ��ʾ��ص�A 
        LOOP A
        
        POP CX		 
		POP DI  
		POP SI 
		POP DX
		POPF
		IRET 

ENDP MYINT 
		END START
CODE ENDS