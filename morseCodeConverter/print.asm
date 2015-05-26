; @author: Muhammad Ilham Jamaludin
; @nim: G64130015

%ifndef udin_print
%define udin_print

print:
	mov eax,4 	;syscall number 4 is to write (32-bit system)
	mov ebx,1	;1 is stdout file descriptor
	int 0x80
	ret

%endif

;Udin