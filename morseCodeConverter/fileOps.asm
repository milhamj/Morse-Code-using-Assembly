; @author: Muhammad Ilham Jamaludin
; @nim: G64130015

%ifndef udin_fileOps
%define udin_fileOPs

createFile:
	mov eax, 8 ;system call for sys_create
	mov ecx, 0777 ;read, write, and execute by all
	int 0x80 ;call kernel
	ret

closeFile:
	mov eax,6	;system call for sys_close
	int 0x80 	;call kernel
	ret

writeFile:
	mov eax,4 ;system call for sys_write
	int 0x80
	ret

openFile:
	mov eax,5
	mov ecx,0 ;read-only
	mov edx,0777 ;read, write, and execute by all
	int 0x80
	ret

readFile
	mov eax, 3 ;sys_read
	int 0x80
	ret


%endif

;Udin	
