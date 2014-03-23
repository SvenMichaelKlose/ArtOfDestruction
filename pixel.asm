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
    ldy char_y
    lda (d),y
    and multicolor_masks,x
    ora multicolor_pixels,x
    sta (d),y
    pla
    tay
    pla
    tax
    rts
.)

multicolor_pixels:
    .byte %00011010
    .byte %10001010
    .byte %10100010
    .byte %10101000

multicolor_masks:
    .byte %00111111
    .byte %11001111
    .byte %11110011
    .byte %11111100
