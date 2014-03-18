main:
clear_zeropage_and_charset:
.(
    ldx #0
    txa
l:  sta 0,x
    sta $1000,x
    inx
    bne l
.)

    jsr clear_screen
    lda #1
    sta next_char

    lda #64
    sta x0
    sta y0

    lda #64+32
    sta x1
    lda #64+10
    sta y1
    jsr draw_line

    lda #64+10
    sta x1
    lda #64+32
    sta y1
    jsr draw_line

    lda #64-10
    sta x1
    lda #64+32
    sta y1
    jsr draw_line

    lda #64-32
    sta x1
    lda #64+10
    sta y1
    jsr draw_line

    lda #64-32
    sta x1
    lda #64-10
    sta y1
    jsr draw_line

    lda #64-10
    sta x1
    lda #64-32
    sta y1
    jsr draw_line

    lda #64+10
    sta x1
    lda #64-32
    sta y1
    jsr draw_line

    lda #64+32
    sta x1
    lda #64-10
    sta y1
    jsr draw_line

    lda #64-32
    sta x0
    sta y0
    lda #64+32
    sta x1
    sta y1
    jsr draw_line

    lda #64
    sta x0
    sta x1
    jsr draw_line

forever:
    jmp forever
