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
    sta x0
    sta y0
    lda #100
    sta x1
    lda #50
    sta y1
    jsr draw_line
.)

forever:
    jmp forever
