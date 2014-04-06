divide:
.(
    lda result
    php
    bpl n
    eor #$ff
    clc
    adc #1
    sta result
n:  jsr unsigned_divide
    plp
    bpl done
    lda result
    eor #$ff
    sta result
    lda result_decimals
    eor #$ff
    sta result_decimals
    inc result_decimals
    bne done
    inc result
done:
    rts
.)
    
; Derived from http://codebase64.org/doku.php?id=base:8bit_divide_8bit_product
unsigned_divide:
.(
    lda #0
    sta result_decimals
    ldx #15
    clc
l:  rol result_decimals
    rol result
    rol
    cmp denominator
    bcc n
    sbc denominator
n:  dex
    bpl l
    rol result_decimals
    rol result
    rts
.)
