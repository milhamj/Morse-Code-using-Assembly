; Programmed by Fakhri Izzudin (G64130030)

; Fungsi untuk print string ke stdout atau stderr, kata harus diakhiri dengan null
; Argument: eax (alamat char pertama), ebx (stdout 1 atau stderr 2)

%ifndef _printStrFunc
%define _printStrFunc

section .data

section .bss

section .text

printStr:

	; Reset pointer ecx dari parameter
	mov ecx, eax

_printStrLoop:

	; Periksa apakah sudah null?
	cmp byte [ecx], 0
	je _printStrExit
	
	; Cetak character
	mov eax, 4
	mov edx, 1
	int 0x80

	; Add counter
	add ecx, 1

	jmp _printStrLoop

_printStrExit:

	ret


%endif