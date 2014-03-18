multiply:
    lda result  ; Signedness of result.
    eor product
    sta tmp
    lda result
    jsr neg
    sta result
    lda product
    jsr neg
    sta product
    jsr unsigned_multiply
    asl tmp
    bcc no_neg
    lda result+1
    eor #$ff
    clc
    adc #1
    sta result+1
no_neg:
    rts

; http://codebase64.org/doku.php?id=base:8bit_multiplication_16bit_product
unsigned_multiply:
.(
    stx save_x
    sty save_y
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
    ldx save_x
    ldy save_y
    rts
.)
