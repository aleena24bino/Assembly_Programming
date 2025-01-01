;Pgm to replace a character within a string

DATA SEGMENT
	str1 DB 20 dup("$")
	cr DB ?
	rc DB ?
	strm DB 13,10, "Enter the string: $"
	repc DB 13,10, "Enter the character to be replaced: $"
	newc DB 13,10, "Enter replacement character: $"
	news DB 13,10, "new string: $"
	nostr DB 13,10, "No occurences $"
DATA ENDS

CODE SEGMENT 
	ASSUME CS:CODE, DS:DATA
	
	START:
		MOV AX, DATA
		MOV DS, AX
		
		;DISPLAY MESSAGE TO ENTER STRING
		LEA DX, strm
		MOV AH,09H
		INT 21H
		
		;STORING THAT INTO STR1
		LEA SI, str1
		MOV CX, 20
		CALL READ
		
		;MARKING THE END WITH $
		MOV BYTE PTR [SI], '$'
		
		;DISPLAYING CHARACTER TO BE REPLACED
		LEA DX,repc
		MOV AH,09H
		INT 21H
		;READING CHARACTER TO BE REPLACED
		MOV AH,01H
		INT 21H
		MOV [cr], AL
		
		;ENTER REPLACEMENT CHARACTER
		LEA DX, newc
		MOV AH, 09H
		INT 21H
		MOV AH, 01H
		INT 21H
		MOV[rc], AL
		
		CALL REPLACE 
		
		MOV AH, 4CH
		INT 21H

	REPLACE:
		LEA SI, str1
		MOV AL,[cr]
		MOV BL,[rc]
		XOR CX,CX ;CLEARS REPLACEMENT COUNTER 
		
		REPLACE_LOOP:
			CMP BYTE PTR [SI], '$'
			JE DONE
			CMP BYTE PTR [SI], AL
			JNE NEXT
			MOV [SI], BL
			INC CX
			
			NEXT:
			INC SI
			JMP REPLACE_LOOP
		
			
		DONE:
			CMP CX,0
			JE NO_OCCURENCES
			LEA DX, news
			MOV AH, 09H
			INT 21H
			LEA DX, str1
			MOV AH, 09H
			INT 21H
		
		RET
	
	NO_OCCURENCES:
		LEA DX, nostr
		MOV AH, 09H
		INT 21H
		RET
		
	READ:
		MOV AH,01H
		INT 21H
		CMP AL, 13
		JE RETURN
		MOV [SI], AL
		INC SI
		LOOP READ
		RETURN:
		RET

CODE ENDS
END START