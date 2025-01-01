;Pgm for concatenation of strings

data segment
	str1 db 30 dup("$")
	str2 db 30 dup("$")
	m1 db 13,10,"Enter string1:$"
	m2 db 13,10,"Enter string2:$"
	res db 13,10,"Concatenated string:$"
data ends
stack segment stack
	dw 128 dup(?)
stack ends
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
	lea si,str2
	call reader
	call concat
	mov ah,4ch
	int 21h
concat:
	lea si,str1
	lea di,str2
	mov al,"$"
str1end:
	cmp al,[si]
	jz append
	inc si
	jmp str1end
append:
	cmp al,[di]
	jz display
	mov bl,[di]
	mov [si],bl
	inc si
	inc di
	jmp append
display:
	mov [si],al
	lea dx,res
	mov ah,09h
	int 21h
	lea dx,str1
	mov ah,09h
	int 21h
	ret
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