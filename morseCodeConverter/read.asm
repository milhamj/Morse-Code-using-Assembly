; @author: Muhammad Ilham Jamaludin
; @nim: G64130015

%ifndef udin_read
%define udin_read

read:
	mov eax,3
	mov ebx,0
	int 0x80
	ret

%endif

;Udin

