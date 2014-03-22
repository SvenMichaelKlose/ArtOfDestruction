draw_pixel:
.(
    txa
    pha
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
    and #3
    sta char_x
    tya
    and #7
    sta char_y
    jsr get_char
    ldx char_x
    lda multicolor_pixels,x
    ldy char_y
    ora (d),y
    sta (d),y
    pla
    tay
    pla
    tax
    rts
.)

multicolor_pixels:
    .byte %00101010
    .byte %10001010
    .byte %10100010
    .byte %10101000
