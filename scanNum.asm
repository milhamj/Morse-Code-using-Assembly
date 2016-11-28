; Programmed by Fakhri Izzudin (G64130030)

; Fungsi untuk membaca angka ke dalam register eax berupa int
; Result: eax (int)

%ifndef _scanNumFunc
%define _scanNumFunc

section .data
	; angka 10
	_scanNumSepuluh dd 10

section .bss
	_scanNumStr resb 1

	; Penampung hasil akhir
	_scanNumResult resd 1

	; negatif? 1:positif atau -1:negatif
	_scanNumNegative resd 1

section .text


_scanNumRead:

	; Baca dari stdin ke _scanNumStr
	mov eax, 3
	mov ebx, 0
	mov ecx, _scanNumStr
	mov edx, 1
	int 0x80

	ret


scanNum:

	; Reset Result dan Negative
	mov dword [_scanNumResult], 0
	mov dword [_scanNumNegative], 1
	
	call _scanNumRead

	; periksa apakah negatif?
	cmp byte[_scanNumStr], '-'
	jne _scanNumLoop

	; Jika negatif
	mov dword [_scanNumNegative], -1
	jmp _scanNumNegativeNext


_scanNumLoop:

	; ebx penampung angka
	mov ebx, 0
	mov bl, byte[_scanNumStr]

	; periksa apakah masih ada angka yang tersisa?
	cmp bl, '0'
	jl _scanNumExit
	cmp bl, '9'
	jg _scanNumExit

	; konversi string ke int
	sub bl, '0'

	; tambahkan ke result
	mov eax, [_scanNumResult]
	mov edx, 0
	mul dword [_scanNumSepuluh]
	add eax, ebx
	mov dword [_scanNumResult], eax

_scanNumNegativeNext:

	; Periksa angka berikutnya
	call _scanNumRead

	jmp _scanNumLoop


_scanNumExit:
	
	; Kalikan dengan negatif
	mov eax, [_scanNumResult]
	cdq
	imul dword[_scanNumNegative]

	ret


%endif