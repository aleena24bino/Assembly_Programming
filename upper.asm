;Pgm to convert lower case to upper case

data segment
	m1 db 13,10,"Enter the string:$"
	m2 db 13,10,"After conversion to upper case:$"
	str1 db 50 dup("$")
	m3 db 13,10,"Invalid input$"
data ends
code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax

	lea dx,m1
	mov ah,09h
	int 21h

	lea si,str1
	call reader
	
	lea dx,m2
	mov ah,09h
	int 21h
	
	lea dx,str1
	mov ah,09h
	int 21h

	mov ah,4ch
	int 21h
reader:
	mov ah,01h
	int 21h
	cmp al,13
	je return
	cmp al,61h
	jae upper
	cmp al,41h
	jae lower
upper:
	cmp al,7Ah
	jnbe invalid
	sub al,20h
	mov [si],al
	inc si
	jmp reader
lower:
	cmp al,5Ah
	jnbe invalid
	mov [si],al
	inc si
	jmp reader
invalid:
	lea dx,m3
	mov ah,09h
	int 21h
	
	mov ah,4ch
	int 21h
	
return:
	ret
code ends
end start