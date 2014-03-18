test_circle:
.(
    lda #0
    sta counter
l:  lda #90
    sta result
    lda counter
    jsr sinmul
    lda #64
    clc
    adc result
    tax

    lda #160
    sta result
    lda counter
    clc
    adc #64+128
    jsr sinmul
    lda #96
    clc
    adc result
    tay
    jsr draw_pixel

    inc counter
    bne l
    rts
.)
