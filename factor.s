global factorization
section .text 

; first argument number
; second argument function for results
factorization:
; stack frame
    push ebp
    mov ebp, esp
    sub esp, 4  ; local variable for number
    
; save registers
    push edi
    push ebx

    mov eax, [ebp+8]    ; number
    mov [ebp-4], eax
    mov edi, [ebp+12]   ; function for results

; move first del
    mov ebx, 2
; process of factorization
    _next_del:
    xor edx, edx
    mov [ebp-4], eax ; save number
    div ebx
    cmp edx, 0
    je _process
    inc ebx      ; inc_del
    mov eax, [ebp-4] ; return number
    jmp _next_del

    _process:
    mov [ebp-4], eax  ; save number
    push ebx        ; process del
    call edi        
    add esp, 4
    mov eax, [ebp-4] ; return number
    cmp eax, 1   ; if number == 1 then stop
    je _return0
    jmp _next_del

    _return0:
    mov eax, 0
; return value registers
    pop ebx
    pop edi

; remove stack frame
    mov esp, ebp
    pop ebp 
    ret 
