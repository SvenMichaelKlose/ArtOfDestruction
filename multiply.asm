; http://codebase64.org/doku.php?id=base:8bit_multiplication_16bit_product
unsigned_multiply:
.(
    lda #$00
    tay
    sty result+1
    beq start

add:clc
    adc result
    tax

    tya
    adc result+1
    tay
    txa

next_bit:
    asl result
    rol result+1
start:
    lsr
    bcs add
    bne next_bit
    rts
.)
