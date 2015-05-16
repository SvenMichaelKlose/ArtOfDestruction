screen_width    = @(* 4 22)
screen_height   = @(* 4 22)

fakexcoords: 0 30 30 0
fakeycoords: 0 10 30 20
fakezcoords: screen_width screen_width screen_width screen_width

world:
    ; Make some polygon.
    ldx #3
l:  lda fakexcoords,x
    sta xcoords,x
    lda fakeycoords,x
    sta ycoords,x
    lda fakezcoords,x
    sta zcoords,x
    dex
    bpl -l

    ; Project points to 2D.
    ldx #3

l:  lda xcoords,x
    sta result
    lda zcoords,x
    sta denominator
    jsr divide
    lda #screen_width
    sta product
    jsr multiply
    lda #@(half screen_width)
    clc
    adc result
    sta polyxcoords,x

    lda ycoords,x
    sta result
    lda zcoords,x
    sta denominator
    jsr divide
    lda #screen_height
    sta product
    jsr multiply
    lda #@(half screen_height)
    clc
    adc result
    sta polyycoords,x

    dex
    bpl -l

    jsr polygon

    rts
