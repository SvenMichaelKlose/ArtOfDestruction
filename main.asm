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

    jsr clear_screen
    lda #1
    sta next_char

    jsr sky_and_ground
    jsr test_octants
    jsr test_circle

forever:
    jmp forever
