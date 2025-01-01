;Pgm to find largest among 1 digit numbers

data segment
	m1 db 13,10,"Enter first number:$"
	m2 db 13,10,"Enter second number:$"
	res db 13,10,"Largest:$"
data ends
code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax
	lea dx,m1
	mov ah,09h
	int 21h
	call read_number
	mov ch,al

	lea dx,m2
	mov ah,09h
	int 21h
	call read_number
	mov bh,al
	
	cmp ch,bh
	jc n2_greater
	call n1_greater
read_number:
	mov ah,01h
	int 21h
	sub al,30h
	ret

n2_greater:
	lea dx,res
	mov ah,09h
	int 21h
	mov al,bh
	add al,30h
	mov dl,al
	mov ah,02h
	int 21h
	call return	
n1_greater:
	lea dx,res
	mov ah,09h
	int 21h
	mov al,ch
	add al,30h
	mov dl,al
	mov ah,02h
	int 21h	
return:
	mov ah,4ch
	int 21h
code ends 
end start
