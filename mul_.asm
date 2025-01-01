;Pgm to multiply 2-digit decimal numbers

data segment
	m1 db 13,10,"Enter first number (0-99):$"
	m2 db 13,10,"Enter second number (0-99):$"
	m3 db 13,10,"Result:$"
	res db '00','$'
	res1 db '00','$'
data ends
code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax

	;1st no.
	lea dx,m1
	mov ah,09h
	int 21h
	call getno
	mov bh,ch
	mov bl,cl

	;2nd no.
	lea dx,m2
	mov ah,09h
	int 21h
	call getno

	mov al,cl
	mul bl
	mov ah,0
	call adjust
	add al,'0'
	mov res1[1],al

	mov dh,ah

	mov al,cl
	mul bh
	add al,dh
	mov ah,0
	call adjust

	mov dh,ah
	mov dl,al
	
	mov al,ch
	mul bl
	add al,dl
	mov ah,0
	call adjust
	add al,'0'
	mov res1[0],al

	mov dl,ah

	mov al,ch
	mul bh
	add al,dl
	add al,dh
	mov ah,0
	call adjust
	add al,'0'
	add ah,'0'
	mov res[1],al
	mov res[0],ah
	

	lea dx,m3
	mov ah,09h
	int 21h
	
	lea dx,res
	mov ah,09h
	int 21h
	
	lea dx,res1
	mov ah,09h
	int 21h

	mov ah,4ch
	int 21h
getno:
	mov ah,01h
	int 21h
	mov ch,al
	mov ah,01h
	int 21h
	mov cl,al
	sub ch,'0'
	sub cl,'0'
	ret
adjust:
	cmp al,0ah
	jb return
	sub al,0ah
	inc ah
	jmp adjust
return:
	ret
code ends
end start