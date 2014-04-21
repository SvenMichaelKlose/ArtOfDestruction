screen_width    = 4*22
screen_height   = 4*22

ourxcoords: .byte 0, 30, 30, 0
ourycoords: .byte 0, 10, 30, 20
ourzcoords: .byte screen_width, screen_width, screen_width, screen_width

world:
    ; Make some polygon.
.(
    ldx #3
l:  lda ourxcoords,x
    sta xcoords,x
    lda ourycoords,x
    sta ycoords,x
    lda ourzcoords,x
    sta zcoords,x
    dex
    bpl l
.)

    ; Project points to 2D.
.(
    ldx #3

l:  lda xcoords,x
    sta result
    lda zcoords,x
    sta denominator
    jsr divide
    lda #screen_width
    sta product
    jsr multiply
    lda #screen_width/2
    clc
    adc result
    sta xproj,x

    lda ycoords,x
    sta result
    lda zcoords,x
    sta denominator
    jsr divide
    lda #screen_height
    sta product
    jsr multiply
    lda #screen_height/2
    clc
    adc result
    sta yproj,x

    dex
    bpl l
.)

    ; Copy to polygon coords.
.(
    ldx #3
l:  lda xproj,x
    sta polyxcoords,x
    lda yproj,x
    sta polyycoords,x
    dex
    bpl l
.)

    jsr polygon

    rts
