main:
clear:
.(
    ldx #0
    txa
l:  sta 0,x
    sta $1000,x
    inx
    bne l
.)

    lda #1
    sta next_char

    jsr clear_screen

plot_circle:
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
.)

forever:
    jmp forever

sinmul:
    jsr sin
    sta product
    jsr multiply
    sta result
    rts
