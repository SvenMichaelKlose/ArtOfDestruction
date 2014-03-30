test_octants:
    lda #32
    sta x0
    lda #64
    sta y0

    lda #32+16
    sta x1
    lda #64+10
    sta y1
    jsr draw_line

    lda #32+5
    sta x1
    lda #64+32
    sta y1
    jsr draw_line

    lda #32-5
    sta x1
    lda #64+32
    sta y1
    jsr draw_line

    lda #32-16
    sta x1
    lda #64+10
    sta y1
    jsr draw_line

    lda #32-16
    sta x1
    lda #64-10
    sta y1
    jsr draw_line

    lda #32-5
    sta x1
    lda #64-32
    sta y1
    jsr draw_line

    lda #32+5
    sta x1
    lda #64-32
    sta y1
    jsr draw_line

    lda #32+16
    sta x1
    lda #64-10
    sta y1
    jsr draw_line

    rts
