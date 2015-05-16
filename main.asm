main:
clear_zeropage_and_charset:
    ; Init chars with char color (which is our background).
    ldx #0
l:  lda #0
    sta 0,x
    lda #%10101010
    sta $1000,x
    inx
    bne -l

    ; Init filling char.
    ldx #7
    lda #%11111111
l:  sta $1008,x
    dex
    bpl -l

    lda #@(+ (* red 16) black)
    sta vicreg_screencol_reverse_border
    lda #@(* yellow 16)
    sta vicreg_auxcol_volume

    jsr clear_screen

    lda #2
    sta next_char

    ; Make red line at the bottom.
    ldx #21
l:  lda #0
    sta @(+ screen (* 22 22)),x
    lda #red
    sta @(+ colors (* 22 22)),x
    dex
    bpl -l

    jsr sky_and_ground
    jsr world

forever:
    jmp forever
