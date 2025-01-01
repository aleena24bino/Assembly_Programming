;Program to add 2 decimal no.s

data segment 
	m1 db 13,10,"Enter n1:$"
	m2 db 13,10,"Enter n2:$"
	res db 13,10,"Sum:$"
data ends
code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax
	
	lea dx,m1	;1st no
	mov ah,09h
	int 21h

	mov ah,01h
	int 21h
	sub al,30h
	mov bh,al

	mov ah,01h
	int 21h
	sub al,30h
	mov bl,al

	lea dx,m2      ;2nd no	
	mov ah,09h
	int 21h

	mov ah,01h
	int 21h
	sub al,30h
	mov ch,al

	mov ah,01h
	int 21h
	sub al,30h
	mov cl,al

	mov dl,00h
	add bl,cl
	cmp bl,0ah
	jc next
	sub bl,0ah
	inc bh

next:
	add bh,ch
	cmp bh,0ah
	jc next1
	sub bh,0ah
	inc dl
next1:
	mov ah,30h
	add bl,ah
	add bh,ah
	add dl,ah
	mov al,dl
	lea dx,res
	mov ah,09h
	int 21h
	mov dl,al
	mov ah,02h
	int 21h
	mov dl,bh
	mov ah,02h
	int 21h
	mov dl,bl
	mov ah,02h
	int 21h
	mov ah,4ch
	int 21h
code ends
end start
	