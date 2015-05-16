divide:
    stx save_x
    sty save_y
    lda result
    php
    bpl +n
    jsr neg
    sta result
n:  jsr unsigned_divide
    plp
    bpl +done
    jsr neg_result
done:
    ldx save_x
    ldy save_y
    rts
    
; Derived from http://codebase64.org/doku.php?id=base:8bit_divide_8bit_product
unsigned_divide:
    lda #0
    sta result_decimals
    ldx #15
    clc
l:  rol result_decimals
    rol result
    rol
    cmp denominator
    bcc +n
    sbc denominator
n:  dex
    bpl -l
    rol result_decimals
    rol result
    rts
