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

forever:
    jmp forever
