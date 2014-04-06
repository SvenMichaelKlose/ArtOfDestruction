main:
clear_zeropage_and_charset:
.(
    ldx #0
l:  lda #0
    sta 0,x
    lda #%10101010  ; Character colors are our background colors.
    sta $1000,x
    inx
    bne l
.)

init_filling_char:
.(
    ldx #7
    lda #%11111111
l:  sta $1008,x
    dex
    bpl l
.)

    lda #red*16+black
    sta vicreg_screencol_reverse_border
    lda #yellow*16
    sta vicreg_auxcol_volume

    jsr clear_screen

    lda #2
    sta next_char

make_red_line_on_bottom:
.(
    ldx #21
l:  lda #0
    sta screen+22*22,x
    lda #red
    sta colors+22*22,x
    dex
    bpl l
.)

    jsr sky_and_ground

    lda #32         ; Our test coordinates.
    sta x_left
    lda #33
    sta x_right
    lda #0
    sta x_bottom_left
    lda #80
    sta x_bottom_right
    lda #0
    sta y_top
    lda #85
    sta y_bottom
    jsr polygon

forever:
    jmp forever
