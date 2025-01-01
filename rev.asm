;Pgm to reverse a string

data segment
	ip db 13,10,"Enter the string:$"
	op db 13,10,"The reversed string is $"
	str1 db 100 dup("$")
	str2 db 100 dup("$")
	len db ?
data ends
code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax
	
	lea dx,ip
	mov ah,09h
	int 21h

	lea dx,str1
	mov ah,0ah
	int 21h

	mov si,offset str1+1
	mov cl,[si]

	mov len,cl
	inc si

	lea di,str2
	
	mov ch,0h
	add si,cx
	dec si
	call reverse
	
	mov byte ptr [di],'$'

	lea dx,op
	mov ah,09h
	int 21h

	lea dx,str2
	mov ah,09h
	int 21h

	mov ah,4ch
	int 21h

reverse:
	cmp cl,0h
	je return
	mov al,[si]
	mov [di],al
	inc di
	dec si
	dec cl
	jmp reverse
return:
	ret
code ends
end start

	
	
	
	
	
	
