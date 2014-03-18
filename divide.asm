; http://codebase64.org/doku.php?id=base:8bit_divide_8bit_product

unsigned_divide:
.(
    lda #$00
    ldx #$07
    clc
l:  rol result
    rol
    cmp denominator
    bcc n
    sbc denominator
n:  dex
    bpl l
    rol result
    rts
.)
