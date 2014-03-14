draw_pixel:
.(
    txa
    pha
    lsr
    lsr
    lsr
    sta scrx
    tya
    pha
    lsr
    lsr
    lsr
    sta scry
    txa
    and #7
    sta char_x
    tya
    and #7
    sta char_y
    jsr get_char
    ldx char_x
    lda bits,x
    ldy char_y
    ora (d),y
    sta (d),y
done:
    pla
    tay
    pla
    tax
    rts
.)
