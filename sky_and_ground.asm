sky_and_ground:
    ldx #@(* 11 22)
    lda #@(+ cyan multicolor)
l:  sta @(-- colors),x
    dex
    bne -l

    ldx #@(* 11 22)
    lda #@(+ green multicolor)
l:  sta @(- colors (++ (* 11 22))),x
    dex
    bne -l
    rts
