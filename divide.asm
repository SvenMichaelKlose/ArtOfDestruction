divide:
.(
    lda result+1
    php
    bpl n
    eor #$ff
    clc
    adc #1
    sta result+1
n:  jsr unsigned_divide
    plp
    bpl done
    lda result+1
    eor #$ff
    sta result+1
    lda result
    eor #$ff
    sta result
    inc result
    bne done
    inc result+1
done:
    rts
.)
    
; Derived from http://codebase64.org/doku.php?id=base:8bit_divide_8bit_product
unsigned_divide:
.(
    lda #0
    sta result
    ldx #15
    clc
l:  rol result
    rol result+1
    rol
    cmp denominator
    bcc n
    sbc denominator
n:  dex
    bpl l
    rol result
    rol result+1
    rts
.)
