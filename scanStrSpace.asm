; Programmed by Fakhri Izzudin (G64130030)

; Fungsi untuk membaca string ke dalam register eax dengan panjang ebx
; Result: eax (alamat character pertama), ebx (int)

%ifndef _scanStrSpaceFunc
%define _scanStrSpaceFunc

section .data

section .bss
	_scanStrCharSpace resb 1
	_scanStrTextSpace resb 256
	_scanStrIndexSpace resd 1

section .text

_scanStrReadSpace:

	; Baca dari stdin ke _scanNumStr
	mov eax, 3
	mov ebx, 0
	mov ecx, _scanStrCharSpace
	mov edx, 1
	int 0x80

	ret


scanStrSpace:
	
	; Reset Index atau Counter
	mov dword [_scanStrIndexSpace], 0


_scanStrLoopSpace:

	; Periksa apakah akan overflow
	cmp dword [_scanStrIndexSpace], 255
	je _scanStrExitSpace

	; Baca character
	call _scanStrReadSpace

	; periksa apakah spasi?
	cmp byte [_scanStrCharSpace], ' '
	je _scanStrExitSpace

	; periksa apakah newline?
	cmp byte [_scanStrCharSpace], 10
	je _scanStrExitSpace2
	
	; periksa apakah null?
	cmp byte [_scanStrCharSpace], 0 
	je _scanStrExitSpace2


	; Tambahkan character pada Text
	mov ecx, [_scanStrIndexSpace]
	mov bl, [_scanStrCharSpace]
	mov byte [_scanStrTextSpace + ecx], bl

	; Increment counter
	add dword [_scanStrIndexSpace], 1

	jmp _scanStrLoopSpace


_scanStrExitSpace:
	
	; tambahkan null space pada akhir kata
	mov ecx, [_scanStrIndexSpace]
	mov byte [_scanStrTextSpace + ecx], 0

	; add counter agar sesuai dengan jumlah kata
	mov ebx, ecx
	sub ebx, 1

	; rubah eax menjadi alamat text dan ebx menjadi panjang text (termasuk null space)
	mov eax, _scanStrTextSpace
	mov ebx, [_scanStrIndexSpace]

	ret

_scanStrExitSpace2:
	
	; tambahkan null space pada akhir kata
	mov ecx, [_scanStrIndexSpace]
	mov byte [_scanStrTextSpace + ecx], 0

	; add counter agar sesuai dengan jumlah kata
	mov ebx, ecx
	sub ebx, 1

	; rubah eax menjadi alamat text dan ebx menjadi panjang text (termasuk null space)
	mov eax, _scanStrTextSpace
	mov ebx, [_scanStrIndexSpace]
	; angka keberuntungan
	mov esi,13
	ret

%endif