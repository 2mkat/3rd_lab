global factor

SECTION .data
len equ 50      ; количество цифр в числе -1
 
 
SECTION .bss
array1 resb len ;массив для перевернутых  чисел
array2 resb len ;массив для перевернутых обратно чисел
chislo resb len ;число введенное
 
SECTION .text
global _start
_start:
; ввод числа с консоли
mov eax, 3      
mov ebx, 0
mov ecx, chislo
mov edx, len
int 80h
 
mov edi, 10    
xor eax, eax
xor ecx, ecx
xor edx, edx
 
 
_trancfer:            
mov bl,[ chislo + edx ]     ; кладем в 8-битовый регистр указатель на первый символ
sub bl, '0'
add eax, ebx                ; к пустому регистру добавляем то что получилось в  dl
inc edx                     ; увеличиваем счетчки на 1, берем следующий символ
mov bl, [chislo+edx]        ; в регистре заменился старый символ на новый символ
cmp bl, 0xa                 ; стравнивается с числом 0
je _qwe                     ; если будет равно 0, то символов больше нет
push edx
xor edx, edx
mul edi
pop edx                    ; умножаем на 10 и идем дальше
jmp _trancfer          
_qwe:                      ; выход из переворота
 
mov ecx, eax
xor edi, edi
xor esi, esi
 
mov ebx, 2                 ; первый простой делитель
_cycl_delenya:             ; цикл деления на первое простое число
xor edx, edx
mov eax, ecx
div ebx                    ; результат будет в AL, а в ah будет остаток
cmp edx, 0x0               ;сравниваю остаток в 0
jne _are_not_equal0        ; если не равно нулю то иду дальше равно на метку
mov ecx, eax               ; число лежит теперь в ecx
push ecx                   ; в стеке лежит число которое явдяется простым
push ebx                   ; а зетем в стек запишется еще одно простое число
 
mov eax, ebx
_del_to_new_massiv:        ;ЗАПИСЫВАЕМ НОВЫЙ МАССИВ ВСЕ ДЕЛИТЕЛИ ЧИСЛА ЗАДОИ НАПЕРЕД
xor edx, edx
mov ebx, 10
div ebx
add edx, '0'
mov ebx, edx
mov [array1+edi], bl
inc edi
cmp eax, 0x0
jne _del_to_new_massiv
 
_hren_naoborot:            ; записываем числа в другой массив начиная с последнего
dec edi
xor eax, eax
mov al, [array1+edi]
mov [array2+esi], al
inc esi
cmp edi, 0x0
jne _hren_naoborot
mov al, '*'
mov [array2+esi],al
inc esi
 
pop ebx
pop ecx
jmp _cycl_delenya
 
_are_not_equal0:            ; увелечение делителя
cmp eax,0x0
je _aaaaa
inc ebx
jmp _cycl_delenya
_aaaaa:
 
mov ecx, array2             ; вывод нового массива без последней клетки
mov edx, esi
dec edx
mov ebx, 1
mov eax, 4
int 80h
 
mov ebx, 0
mov eax, 1
int 80h