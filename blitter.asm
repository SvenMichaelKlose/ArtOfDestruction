blit_clear_char:
.(
    ldy #7
    lda #%10101010
l1: sta (d),y
    dey
    bpl l1
    rts
.)
