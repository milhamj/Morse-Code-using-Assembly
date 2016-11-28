; Programmed by Fakhri Izzudin (G64130030)

; Fungsi untuk mencetak angka dari eax
; Argument: eax (int)

%ifndef _printNumFunc
%define _printNumFunc

_printNumStrLen equ 255

section .data
	; Angka 10
	_printNumSepuluh dd 10

	; Negative? 1: positive -1: negative
	_printNumNegative dd 1

section .bss
	; Tempat penampungan string yang akan dicetak
	_printNumStr resb _printNumStrLen

section .text

printNum:
	
	; Reset ecx -> index terakhir string yang akan dicetak
	mov ecx, _printNumStrLen
	sub ecx, 1
	; Reset negative
	mov dword [_printNumNegative], 1

	; Periksa apakah eax bernilai 0?
	cmp eax, 0
	jne _printNumCekNegative

	; Jika bernilai 0
	mov byte [_printNumStr + ecx], '0'
	sub ecx, 1
	jmp _printNumCetak

_printNumCekNegative:
	; Periksa apakah negative?
	cmp eax, 0
	jg _printNumLoop

	; Jika bernilai negative
	mov dword [_printNumNegative], -1
	mov edx, 0
	mov eax, eax
	cdq
	imul dword [_printNumNegative]


_printNumLoop:

	; eax dibagi 10 untuk di ambil belakang (edx) dan depan (eax)
	mov edx, 0
	div dword [_printNumSepuluh]

	; konversi int to string
	add dl, '0'
	mov byte [_printNumStr + ecx], dl

	sub ecx, 1

	cmp eax, 0
	jne _printNumLoop


_printNumCetak:

	; Periksa apakah nilainya negative?
	cmp dword [_printNumNegative], -1
	jne _printNumCetakNext

	; tambahkan tanda '-' jika nilai lebih kecil dari 0
	mov byte [_printNumStr + ecx], '-'
	sub ecx, 1


_printNumCetakNext:

	; menghitung panjang angka yang dicetak
	mov edx, _printNumStrLen
	sub edx, ecx
	sub edx, 1

	; mencari alamat indeks pertama yang akan dicetak
	add ecx, _printNumStr
	add ecx, 1

	; perintah print ke stdout
	mov eax, 4
	mov ebx, 1
	int 0x80

_printNumExit:

	ret


%endif