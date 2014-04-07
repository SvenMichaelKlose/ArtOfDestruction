abs:
    bpl abs_end
neg:eor #$ff
    clc
    adc #1
abs_end:
    rts

cosmul:
    sec
    sbc #64
sinmul:
    jsr sin
    sta product
    jsr multiply
    sta result
    rts

point_on_circle:
.(
    lda radius
    sta result
    lda degrees
    jsr sinmul
    lda xpos
    clc
    adc result
    tax

    lda radius
    sta result
    lda degrees
    jsr cosmul
    lda ypos
    clc
    adc result
    tay

    rts
.)
