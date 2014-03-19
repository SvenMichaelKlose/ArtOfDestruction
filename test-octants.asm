test_octants:
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
    jmp draw_line
