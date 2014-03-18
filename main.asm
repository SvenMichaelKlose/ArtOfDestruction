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


.(
    lda #0
    sta counter
l:  lda counter
    asl
    jsr sin
    cmp #$80
    ror
    clc
    adc #64
    tay
    ldx counter
    jsr draw_pixel
    inc counter
    bpl l
.)

forever:
    jmp forever

.(
    lda #0
    sta counter
l:  lda #64
    sta result
    lda counter
    jsr sinmul
    lda #64
    clc
    adc result+1
    tax

    lda #64
    sta result
    lda counter
    eor #128
    jsr sinmul
    lda #64
    clc
    adc result+1
    tay
    jsr draw_pixel

    inc counter
    bne l
.)

sinmul:
    jsr sin
    sta product
    jmp multiply
