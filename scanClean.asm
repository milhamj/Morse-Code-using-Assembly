; Programmed by Fakhri Izzudin (G64130030)

; Fungsi untuk membaca string ke dalam register eax dengan panjang ebx
; Result: eax (alamat character pertama), ebx (int)

%ifndef _scanStrFunc
%define _scanStrFunc

section .data

section .bss
	_scanStrChar resb 1
	_scanStrText resb 256
	_scanStrIndex resd 1

section .text

_scanStrRead:

	; Baca dari stdin ke _scanNumStr
	mov eax, 3
	mov ebx, 0
	mov ecx, _scanStrChar
	mov edx, 1
	int 0x80

	ret


scanStr:
	
	; Reset Index atau Counter
	mov dword [_scanStrIndex], 0


_scanStrLoop:

	; Periksa apakah akan overflow
	cmp dword [_scanStrIndex], 255
	je _scanStrExit

	; Baca character
	call _scanStrRead

	; periksa apakah spasi?
	cmp byte [_scanStrChar], ' '
	je _scanStrExit

	; periksa apakah newline?
	cmp byte [_scanStrChar], 10
	je _scanStrExit
	
	; periksa apakah null?
	cmp byte [_scanStrChar], 0 
	je _scanStrExit


	; Tambahkan character pada Text
	mov ecx, [_scanStrIndex]
	mov bl, [_scanStrChar]
	mov byte [_scanStrText + ecx], bl

	; Increment counter
	add dword [_scanStrIndex], 1

	jmp _scanStrLoop


_scanStrExit:
	
	; tambahkan null space pada akhir kata
	mov ecx, [_scanStrIndex]
	mov byte [_scanStrText + ecx], 0

	; add counter agar sesuai dengan jumlah kata
	mov ebx, ecx
	sub ebx, 1

	; rubah eax menjadi alamat text dan ebx menjadi panjang text (termasuk null space)
	mov eax, _scanStrText
	mov ebx, [_scanStrIndex]

	ret


%endif