main:
clear_zeropage_and_charset:
.(
    ldx #0
l:  lda #0
    sta 0,x
    lda #%10101010
    sta $1000,x
    inx
    bne l
.)

    lda #red*16+black
    sta vicreg_screencol_reverse_border
    lda #yellow*16
    sta vicreg_auxcol_volume
    jsr clear_screen
    lda #1
    sta next_char

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
;    jsr test_octants
;    jsr test_circle
    jsr polygon

forever:
    jmp forever
