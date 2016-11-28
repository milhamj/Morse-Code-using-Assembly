; Programmed by Fakhri Izzudin (G64130030)

; Fungsi untuk print character ke stdout atau stderr
; Argument: al (char), ebx (stdout 1 atau stderr 2)

%ifndef _printChar
%define _printChar

section .data

section .bss
	_printCharCetak resb 1

section .text

printChar:

	mov byte [_printCharCetak], al
	mov eax, 4
	mov ecx, _printCharCetak
	mov edx, 1
	int 0x80

_printCharExit:

	ret


%endif