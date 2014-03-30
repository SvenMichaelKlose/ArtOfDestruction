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
    .byte %01000000
    .byte %00010000
    .byte %00000100
    .byte %00000001

    .byte %11000000
    .byte %00110000
    .byte %00001100
    .byte %00000011

    .byte 0, 0, 0, 0

multicolor_masks:
    .byte %00111111
    .byte %11001111
    .byte %11110011
    .byte %11111100
