; Muhammad Ilham Jamaludin (G64130015)
; Billy Ardhiaseno (G64130065)

; Fungsi untuk scan angka
; Result: eax (int)
%include "scanNum.asm"

; Fungsi untuk cetak angka
; Argument: eax (int)
%include "printNum.asm"

; Fungsi untuk print character ke stdout atau stderr
; Argument: al (char), ebx (stdout 1 atau stderr 2)
%include "printChar.asm"

; Fungsi untuk membaca kata
; Result: eax (alamat character pertama), ebx (int atau panjang kata)
%include "scanStr.asm"
%include "scanStrSpace.asm"

; Fungsi untuk print string ke stdout atau stderr, kata harus diakhiri dengan null
; Argument: eax (alamat char pertama), ebx (stdout 1 atau stderr 2)
%include "printStr.asm"

; Fungsi untuk membandingkan 2 kata, kata harus diakhiri dengan null
; Argument: eax (alamat char pertama kata ke 2), ebx (alamat char pertama kata ke 2)
; Result: eax (1: sama, 0: beda)
%include "cmpStr.asm"

; Fungsi untuk copy dari kata1 (dari eax) ke kata2 (dari ebx) --> ebx = eax, harus diakhiri null
; Argument: eax (alamat character pertama yang akan dicopy), ebx (alamat character pertama hasil)
%include "cpyStr.asm"

%include "clear_screen.asm"

section .data
	angka dd n0,n1,n2,n3,n4,n5,n6,n7,n8,n9
	huruf dd a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
	mark dd comma,hypen,period,slash
	a db '.-',0
	b db '-...',0
	c db '-.-.',0
	d db '-..',0
	e db '.',0
	f db '..-.',0
	g db '--.',0
	h db '....',0
	i db '..',0
	j db '.---',0
	k db '-.-',0
	l db '.-..',0
	m db '--',0
	n db '-.',0
	o db '---',0
	p db '.--.',0
	q db '--.-',0
	r db '.-.',0
	s db '...',0
	t db '-',0
	u db '..-',0
	v db '...-',0
	w db '.--',0
	x db '-..-',0
	y db '-.--',0
	z db '--..',0
	n0 db '-----',0
	n1 db '.----',0
	n2 db '..---',0
	n3 db '...--',0
	n4 db '....-',0
	n5 db '.....',0
	n6 db '-....',0
	n7 db '--...',0
	n8 db '---..',0
	n9 db '----.',0	
	comma db '--..--',0
	hypen db '-....-',0
	period db '.-.-.-',0
	slash db '-..-.',0	
	menu 	db '---------                      Select Operation:                      ---------',10,
			db '---------        1. Convert Text-to-MorseCode w/ Caesar Cipher        ---------',10,
			db '---------        2. Convert MorseCode-to-Text w/ Caesar Cipher        ---------',10,
			db '---------                3. Convert Text-to-MorseCode                 ---------',10,
			db '---------                4. Convert MorseCode-to-Text                 ---------',10,10,10,0
	err1 	db '---------                 Error! Undefined Operation.                 ---------',10,
			db '                -----------------Restarting------------------                ',10,10,10,0
	lagi	db 10,10,10,'---------                  Do you want to try again?                 ----------',10,
			db '---------                           1. Yes                           ----------',10,
			db '---------                           2. No                            ----------',10,10,10,0
	input 	db 10,10,'---------                     Enter your input..                     ----------',10,10,10,0
	input1 	db 10,10,'---------                     Enter your input..                     ----------',10,
			db 'Only letters(A-Z), numbers(0-9), comma(,), period(.), hypen(-), and slash(/) are allowed',10,10,10,0
	thanks 	db '---------                       Thank you...                         ---------',10,10,
			db '               ------Muhammad Ilham Jamaludin G64130015------                ',10,
			db '               ----------Billy Ardhiaseno G64130065----------                ',10,10,
			db '---------                      | IPB @ 2015 |                        ---------',10,10,10,0

section .bss
	string resb 255
	length resd 1
	temp resb 10


section .text
	global main

main:
	call clear_screen
	mov edi,0
	mov esi,0
	mov eax,menu
	mov ebx,1
	call printStr

	call scanNum
	cmp eax,1
	je text_to_morse_w_cc
	cmp eax,2
	je morse_to_text_w_cc
	cmp eax,3
	je text_to_morse
	cmp eax,4
	je morse_to_text_input	
	jmp _err1

_err1:
	mov eax,err1
	mov ebx,1
	call printStr
	jmp main 

	text_to_morse_w_cc
	mov esi,13 ; Lucky Number

	text_to_morse:
		; Print input message
		mov eax,input1
		mov ebx,1
		call printStr

		call scanStr

		; Copy ke string
		mov ebx, string
		call cpyStr

		;Capitalize all the letters
		mov ecx,0
		jmp loop_k
		end_of_loop_k:

		;Print the capitalized letters
		mov eax, string
		mov ebx, 1
		call printStr

		;Print newline
		mov al,10
		mov ebx,1
		call printChar

		;Check the lucky number
		cmp esi,13
		jne begin_conv

		;Caesar Cipher
		mov ecx,0
		jmp loop_cc
		end_of_loop_cc:

		;Print the result of Caesar Cipher
		mov eax, string
		mov ebx, 1
		call printStr

		;Print newline
		mov al,10
		mov ebx,1
		call printChar

		begin_conv:
		;Begin the conversion
		mov edi,0
		push edi
		jmp loop_conv
		end_of_loop_conv:

		;Print newline
		mov al, 10
		mov ebx, 1
		call printChar

		jmp try_again

		loop_k:
			mov al,[string+ecx]
			cmp al,0
			je end_of_loop_k
			cmp al,97
			jge kapitalkan
			inc ecx
			jmp loop_k

		kapitalkan:
			sub al,32
			mov byte [string+ecx*1], al
			inc ecx
			jmp loop_k

		loop_cc:
			mov al,[string+ecx]
			cmp al,0
			je end_of_loop_cc
			cmp al,' '
			je kucing
			cmp al,65
			jl kucing
			add al,3
			cmp al,91
			jge special_cc
			mov [string+ecx],al
			inc ecx
			jmp loop_cc

		kucing:
			inc ecx
			jmp loop_cc

		special_cc:
			sub al,26
			mov [string+ecx],al
			inc ecx
			jmp loop_cc

		;Conversion
		loop_conv:
			pop edi
			mov al,[string+edi]
			push edi
			cmp al,0 ;Check if the char is NULL, if yes, end the loop
			je end_of_loop_conv
			cmp al,' ' ; Check if it's space
			je thats_space

			mov dl,'/' ; Check if the char is a mark first
			cmp dl,al
			jge print_mark

			mov dl,'9' ; Then check if the char is a number
			cmp dl,al
			jge print_angka
			
			mov dl,'Z' ; Then check if the char is a letter
			cmp dl,al
			jge print_huruf


		; If the character is a number
		print_angka:
			sub al,'0'
			mov ecx,0
			mov cl,al
			mov eax,[angka+ecx*4]
			mov ebx,1
			call printStr
			pop edi
			inc edi
			push edi
			call print_space	
			jmp loop_conv

		; If the character is a letter
		print_huruf:
			sub al,'A'
			mov ecx,0
			mov cl,al
			mov eax,[huruf+ecx*4]
			mov ebx,1
			call printStr
			pop edi 	
			inc edi 
			push edi 
			call print_space
			jmp loop_conv

		print_mark:
			sub al,','
			mov ecx,0
			mov cl,al
			mov eax,[mark+ecx*4]
			mov ebx,1
			call printStr
			pop edi 	
			inc edi 
			push edi 
			call print_space
			jmp loop_conv

		;Wait, that's space
		thats_space:
			mov al,'/'
			mov ebx,1
			call printChar
			call print_space
			pop edi 
			inc edi 
			push edi 
			jmp loop_conv

		;This print space, that's all
		print_space:
			mov al,' '
			mov ebx,1
			call printChar
			ret

	morse_to_text_w_cc:
		mov edi,13 ;Lucky Number
		jmp morse_to_text_input

	morse_to_text_input:
		; Print input message
		mov eax,input
		mov ebx,1
		call printStr

	morse_to_text:

		call scanStrSpace

		;simpan ke string
		mov ebx,string
		call cpyStr

		;Conversion
		mov ecx,0
		loop_cmp1
			cmp ecx,26
			je end_of_loop_cmp1
			mov eax,string
			mov ebx,[huruf+ecx*4]
			call cmpStr
			cmp eax,1 ;Check if it's the same letter
			je with_or_without
			inc ecx
			jmp loop_cmp1

		with_or_without:
			cmp edi,13
			je decode_cc
			jmp print_equal

		decode_cc: 
			cmp ecx,0
			je special_decode_cc0
			cmp ecx,1
			je special_decode_cc1
			cmp ecx,2
			je special_decode_cc2
			sub ecx,3
			jmp print_equal

		special_decode_cc0:
			mov ecx,23
			jmp print_equal

		special_decode_cc1:
			mov ecx,24
			jmp print_equal
			
		special_decode_cc2:
			mov ecx,25
			jmp print_equal	

		print_equal:
			add ecx,'A'
			mov eax,ecx
			mov ebx,1
			call printChar
			cmp esi,13
			je end_morse_to_text
			jmp end_if_equal

		end_of_loop_cmp1:
		mov ecx,0

		loop_cmp2
			cmp ecx,10
			je end_of_loop_cmp2
			mov eax,string
			mov ebx,[angka+ecx*4]
			call cmpStr
			cmp eax,1
			je print_equal2
			inc ecx
			jmp loop_cmp2

		print_equal2:
			add ecx,'0'
			mov eax,ecx
			mov ebx,1
			call printChar
			cmp esi,13
			je end_morse_to_text
			jmp end_if_equal		

		end_of_loop_cmp2:
		mov ecx,0

		loop_cmp3:
			cmp ecx,4
			je end_if_not_equal
			mov eax,string
			mov ebx,[mark+ecx*4]
			call cmpStr
			cmp eax,1
			je print_equal3
			inc ecx
			jmp loop_cmp3

		print_equal3:
			add ecx,','
			mov eax,ecx
			mov ebx,1
			call printChar
			cmp esi,13
			je end_morse_to_text
			jmp end_if_equal	

		end_if_not_equal:
			mov eax,string
			mov byte [temp],'/'
			mov ebx,temp
			call cmpStr
			cmp eax,1
			je print_space2

			mov byte [temp],'?'
			mov al,[temp]
			mov ebx,1
			call printChar
			cmp esi,13
			je end_morse_to_text
			jmp morse_to_text

		print_space2:
			mov al,' '
			mov ebx,1
			call printChar
			cmp esi,13
			je end_morse_to_text


		end_if_equal:
			jmp morse_to_text

		end_morse_to_text
			mov al, 10
			mov ebx, 1
			call printChar
			jmp try_again

		try_again:
			mov eax,lagi 
			mov ebx,1
			call printStr

			call scanNum
			cmp eax,1
			je main
			cmp eax,2
			je exit
			jmp _err2

		_err2:
			mov eax,err1
			mov ebx,1
			call printStr
			jmp try_again


exit:
	call clear_screen
	mov eax,thanks
	mov ebx,1
	call printStr

	mov eax, 1
	mov ebx, 0
	int 0x80
