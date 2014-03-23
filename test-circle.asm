test_circle:
.(
    lda #0
    sta counter

l:  lda #45
    sta result
    lda counter
    jsr sinmul
    lda #32
    clc
    adc result
    tax

    lda #160
    sta result
    lda counter
    jsr cosmul
    lda #96
    clc
    adc result
    tay

    jsr draw_pixel

    inc counter
    bne l
    rts
.)
