sky_and_ground:
.(
    ldx #11*22
    lda #cyan+multicolor
l:  sta colors-1,x
    dex
    bne l

    ldx #11*22
    lda #green+multicolor
l2: sta colors-1+11*22,x
    dex
    bne l2
    rts
.)
