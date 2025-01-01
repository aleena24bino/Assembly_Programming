data segment
	m1 db 13,10,"Enter the string:$"
	m2 db 13,10,"String you entered:$"
	m3 db 13,10,"Length of the string:$"
	str1 db 30 dup("$")
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

	mov byte ptr [si],'$'
	mov byte ptr [si+1], 0

	
	lea dx,m2
	mov ah,09h
	int 21h

	lea dx,str1
	mov ah,09h 
	int 21h

	mov cl,0h
	lea di,str1
	
	call len
	mov al,cl
	mov ah,0
	call adjust

	mov cl,al
	mov ch,ah

	lea dx,m3
	mov ah,09h
	int 21h
	
	add ch,30h
	mov dl,ch
	mov ah,02h
	int 21h

	add cl,30h
	mov dl,cl
	mov ah,02h
	int 21h

	mov ah,4ch
	int 21h
len:
	mov al,[di]
	cmp al,'$'
	je return
	inc cl
	inc di
	jmp len
adjust:
	cmp al,9h
	jbe return
	sub al,0ah
	inc ah
	jmp adjust
reader:
	mov ah,01h
	int 21h
	cmp al,13
	je return
	mov [si],al
	inc si
	jmp reader
return:
	ret
code ends
end start