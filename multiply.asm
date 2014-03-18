multiply:
    stx save_x
    sty save_y

    lda result  ; Signedness of result.
    eor product
    sta tmp

    lda product
    jsr abs
    sta product

    jsr unsigned_multiply
    tya

    asl tmp
    bcc no_neg
    jsr neg

no_neg:
    ldx save_x
    ldy save_y
    rts

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
    lsr product
    bcs add
    bne next_bit
    rts
.)
