polygon:
.(
    lda #32         ; Our test coordinates.
    sta xl
    lda #33
    sta xr
    lda #0
    sta xbl
    lda #80
    sta xbr
    lda #0
    sta yt
    lda #85
    sta yb

    lda #0          ; Clear decimal places.
    sta xlf
    sta xrf
    sta xrcf
    sta xrcf

    lda yb
    sec
    sbc yt
    sta height
    sta denominator

    lda xbl         ; slope left
    sec
    sbc xl
    sta result+1
    jsr divide
    lda result
    sta xsl
    lda result+1
    sta xsl+1

    lda xbr         ; slope right
    sec
    sbc xr
    sta result+1
    jsr divide
    lda result
    sta xsr
    lda result+1
    sta xsr+1

fill_with_chars:
    lda height
    lsr
    lsr
    beq draw_edges
    sta rows

    lda xl
    lsr
    lsr
    sta xlc
    sta xrc
    inc xlc
    dec xrc

    lda yt
    lsr
    lsr
    sta scry
    lda #0
    sta scrx

ycloop:
    jsr scraddr

    lda xrc
    sec
    sbc xlc
    bcc no_fill
    tax

    ldy xlc
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

    lda xlcf        ; Step left slope.
    clc
    adc xsl
    sta xlcf
    lda xlc
    adc xsl+1
    sta xlc

    lda xrcf        ; Step right slope.
    clc
    adc xsr
    sta xrcf
    lda xrc
    adc xsr+1
    sta xrc

    jmp ycloop

draw_edges:
yloop:
    lda yt
    and #3
    asl
    sta charline

    lda yt
    lsr
    lsr
    sta scry
    lda xl
    lsr
    lsr
    sta scrx
    jsr scraddr

    lda xr
    sec
    sbc xl
    sta width

    lda xl
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

    inc yt

    lda xlf     ; Step left slope.
    clc
    adc xsl
    sta xlf
    lda xl
    adc xsl+1
    sta xl

    lda xrf     ; Step right slope.
    clc
    adc xsr
    sta xrf
    lda xr
    adc xsr+1
    sta xr

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
