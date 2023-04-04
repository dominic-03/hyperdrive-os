org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

main:
    ; segment setup
    mov ax, 0
    mov ds, ax
    mov es, ax

    ; stack setup
    mov ss, ax
    mov sp, 0x7C00

    ; print
    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt


; Print a string to the screen with parameters:
;   - ds:si points to string
puts:
    ; save registers to be modified
    push si
    push ax
    push bx

.loop:
    lodsb       ; load next character from al
    or al, al   ; check if next character is null
    jz .done    ; if next character is null, exit loop

    mov ah, 0x0e ; interrupt
    mov bh, 0
    int 0x10

    jmp .loop

.done:
    pop ax
    pop si
    ret

msg_hello: db 'Hello world!', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h