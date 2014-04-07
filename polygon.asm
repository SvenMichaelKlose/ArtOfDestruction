opposite_points:
    .byte 2
previous_points:
    .byte 3, 0,
next_points:
    .byte 1, 2, 3, 0

point_to_left:
    lda polyxcoords,x
    sta x_bottom_left
    lda polyycoords,x
    sta y_bottom_left
    rts

point_to_right:
    lda polyxcoords,x
    sta x_bottom_right
    lda polyycoords,x
    sta y_bottom_right
    rts

calculate_slope_left:
    lda y_bottom_left
    sec
    sbc y_top
    sta height_left
    sta denominator
    lda x_bottom_left
    sec
    sbc x_left
    sta result
    jsr divide
    lda result_decimals
    sta slope_left_decimals
    lda result
    sta slope_left
    rts

calculate_slope_right:
    lda y_bottom_right
    sec
    sbc y_top
    sta height_right
    sta denominator
    lda x_bottom_right
    sec
    sbc x_right
    sta result
    jsr divide
    lda result_decimals
    sta slope_right_decimals
    lda result
    sta slope_right
    rts

polygon:
.(
find_highest_point_in_quad:
    ldx #0
    lda #255
l:  cmp polyycoords,x
    bcs found_point
    lda polyycoords,x
    inx
    jmp l
found_point:
    txa
    and #3
    tax

make_top_section:
    lda polyxcoords,x
    sta x_left
    sta x_right
    inc x_right
    lda polyycoords,x
    sta y_top

    lda previous_points,x
    sta point_left
    tax
    jsr point_to_left

    lda opposite_points,x
    sta point_right
    tax
    jsr point_to_right

    jsr calculate_slope_left
    jsr calculate_slope_right

calculate_height:
    lda height_right
    cmp height_left
    bcc n1
    lda height_left
n1: sta section_height
    sta height

    jsr fill_polygon_section

    lda point_left
    cmp point_right
    beq done

    lda height_left
    sec
    sbc section_height
    sta height_left
    bne no_update_left
    ldx point_left
    lda previous_points,x
    sta point_left
    tax
    jsr point_to_left
    jsr calculate_slope_left
no_update_left:

    lda height_right
    sec
    sbc section_height
    sta height_right
    bne no_update_right
    ldx point_right
    lda next_points,x
    sta point_right
    tax
    jsr point_to_right
    jsr calculate_slope_right
no_update_right:

    jmp calculate_height

done:
    rts
.)

fill_polygon_section:
.(
    lda #1
    sta filler_set+1
    sta filler_test2+1
    sta filler_test3+1

    lda #0          ; Clear decimal places.
    sta x_left_decimals
    sta x_right_decimals
    sta x_char_right_decimals
    sta x_char_left_decimals

fill_with_chars:
    lda height
    lsr
    lsr
    beq draw_edges
    sta rows

    lda y_top
    lsr
    lsr
    sta scry
    lda #0
    sta scrx

    lda x_left
    lsr
    lsr
    sta x_char_left
    inc x_char_left
    lda x_right
    lsr
    lsr
    sta x_char_right
    dec x_char_right

ycloop:
    jsr scraddr

    lda x_char_right         ; Number of chars in row.
    sec
    sbc x_char_left
    bcc no_fill
    tax

    ldy x_char_left
filler_set:
    lda #0

xcloop:
    sta (scr),y
    iny
    dex
    bpl xcloop

no_fill:
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

    dec rows
    beq draw_edges

    inc scry
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
    tax
    lda (scr),y
filler_test3:
    cmp #0
    bne c1
    lda width
    clc
    sbc negate4,x
    sta width
    jmp c2

c1: lda negate4,x
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

c2: ldy scrx
skip_done:
    iny

filler_test:
    lda (scr),y
filler_test2:
    cmp #0
    bne no_skip
    lda width
    sec
    sbc #4
    sta width
    beq end_of_line_without_plotting
    jmp skip_done

no_skip:
    sty scrx
    ldx #3
    jmp xloop

end_of_line:
    sta (d),y
    iny
    sta (d),y

end_of_line_without_plotting:
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

    dec height
    beq done

    inc y_top
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
