clear_screen:
    ldx #253
    lda #0
l:  sta @(-- screen),x
    sta @(+ screen 252),x
    dex
    bne -l
    rts
screen_h = >screen

scraddr:
    ldy scry
    lda $edfd,y
    sta scr
    sta col
    cpy #12
    lda #@(half screen_h)
    rol
    sta @(++ scr)
    ldy scrx
    rts

scrcoladdr:
    ldy scry
    lda $edfd,y
    sta scr
    sta col
    cpy #12
    lda #@(half screen_h)
    rol
    sta @(++ scr)
    and #1
    ora #>colors
    sta @(++ col)
    ldy scrx
    rts
