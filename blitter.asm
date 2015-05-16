blit_clear_char:
    ldy #7
    lda #%10101010
l:  sta (d),y
    dey
    bpl -l
    rts
