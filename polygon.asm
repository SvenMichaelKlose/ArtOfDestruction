xlf:    .byte 0
xl:     .byte 32
xrf:    .byte 0
xr:     .byte 32
xbl:    .byte 16
xbr:    .byte 40
yt:     .byte 0
yb:     .byte 60

row:    .byte 0
width:  .byte 0
height: .byte 0
xsl:    .word 0
xsr:    .word 0

polygon:
.(
    lda yb
    sec
    sbc yt
    sta height
    sta denominator

    lda xl              ; slope left
    sec
    sbc xbl
    sta result+1
    jsr unsigned_divide
    lda result
    sta xsl
    lda result+1
    sta xsl+1

    lda xbr             ; slope right
    sec
    sbc xr
    sta result+1
    jsr unsigned_divide
    lda result
    sta xsr
    lda result+1
    sta xsr+1

yloop:
    lda yt
    lsr
    lsr
    sta scry
    lda xl
    lsr
    lsr
    sta scrx

    lda xr
    sec
    sbc xl
    sta width
    inc width

    lda xl
    and #3
    tax
    lda negate4,x
    tax

xloop:
    jsr get_char
    lda yt
    and #3
    asl
    tay
    lda (d),y
stay_on_char:
    and pixelmask_r,x
    ora polypixels,x
    dec width
    beq end_of_line
    dex
    bpl stay_on_char
    sta (d),y
    iny
    sta (d),y
    dey
    inc scrx
    ldx #3
    jmp xloop

end_of_line:
    sta (d),y
    iny
    sta (d),y

    dec height
    beq done

    inc yt

    lda xlf
    sec
    sbc xsl
    sta xlf
    lda xl
    sbc xsl+1
    sta xl

    lda xrf
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

pixelmask_r:
    .byte %11111100
    .byte %11110011
    .byte %11001111
    .byte %00111111

polypixels::
    .byte %00000001
    .byte %00000100
    .byte %00010000
    .byte %01000000
