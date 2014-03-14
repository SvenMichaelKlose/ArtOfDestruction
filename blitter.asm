blit_clear_char:
.(
    ldy #7
    lda #0
l1: sta (d),y
    dey
    bpl l1
    rts
.)
