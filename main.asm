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
l:  jsr draw_line
    inc y0
    inc y1
    inc y0
    inc y1
    lda y0
    cmp #50
    bcc l
.)

forever:
    jmp forever
