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
