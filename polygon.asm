polygon:
.(
    lda #32         ; Our test coordinates.
    sta x_left
    lda #33
    sta x_right
    lda #0
    sta x_bottom_left
    lda #80
    sta x_bottom_right
    lda #0
    sta y_top
    lda #85
    sta y_bottom

    lda #0          ; Clear decimal places.
    sta x_left_decimals
    sta x_right_decimals
    sta x_char_right_decimals
    sta x_char_left_decimals

    lda y_bottom
    sec
    sbc y_top
    sta height
    sta denominator

    lda x_bottom_left         ; slope left
    sec
    sbc x_left
    sta result
    jsr divide
    lda result_decimals
    sta slope_left_decimals
    lda result
    sta slope_left

    lda x_bottom_right         ; slope right
    sec
    sbc x_right
    sta result
    jsr divide
    lda result_decimals
    sta slope_right_decimals
    lda result
    sta slope_right

fill_with_chars:
    lda height
    lsr
    lsr
    beq draw_edges
    sta rows

    lda x_left
    lsr
    lsr
    sta x_char_left
    sta x_char_right
    inc x_char_left
    dec x_char_right

    lda y_top
    lsr
    lsr
    sta scry
    lda #0
    sta scrx

ycloop:
    jsr scraddr

    lda x_char_right         ; Number of chars in row.
    sec
    sbc x_char_left
    bcc no_fill
    tax

    ldy x_char_left
    lda #1

xcloop:
    sta (scr),y
    iny
    dex
    bpl xcloop

no_fill:
    dec rows
    beq draw_edges

    inc scry

    lda x_char_left_decimals        ; Step left slope.
    clc
    adc slope_left_decimals
    sta x_char_left_decimals
    lda x_char_left
    adc slope_left
    sta x_char_left

    lda x_char_right_decimals        ; Step right slope.
    clc
    adc slope_right_decimals
    sta x_char_right_decimals
    lda x_char_right
    adc slope_right
    sta x_char_right

    jmp ycloop

draw_edges:
yloop:
    lda y_top
    and #3
    asl
    sta charline

    lda y_top
    lsr
    lsr
    sta scry
    lda x_left
    lsr
    lsr
    sta scrx
    jsr scraddr

    lda x_right
    sec
    sbc x_left
    sta width

    lda x_left
    and #3
    beq filler_test
    tax
    lda negate4,x
    tax

xloop:
    jsr get_char
    ldy charline
    lda (d),y
stay_on_char:
    and pixelmasks,x
    ora polypixels,x
    dec width
    beq end_of_line
    dex
    bpl stay_on_char

    sta (d),y
    iny
    sta (d),y

    ldy scrx
skip_done:
    iny
filler_test:
    lda (scr),y
    cmp #1
    bne no_skip
    lda width
    sec
    sbc #4
    sta width
    jmp skip_done

no_skip:
    sty scrx
    ldx #3
    jmp xloop

end_of_line:
    sta (d),y
    iny
    sta (d),y

    dec height
    beq done

    inc y_top

    lda x_left_decimals     ; Step left slope.
    clc
    adc slope_left_decimals
    sta x_left_decimals
    lda x_left
    adc slope_left
    sta x_left

    lda x_right_decimals     ; Step right slope.
    clc
    adc slope_right_decimals
    sta x_right_decimals
    lda x_right
    adc slope_right
    sta x_right

    jmp yloop

done:
    rts
.)

pixelmasks:
    .byte %11111100
    .byte %11110011
    .byte %11001111
    .byte %00111111

polypixels:
    .byte %00000001
    .byte %00000100
    .byte %00010000
    .byte %01000000
