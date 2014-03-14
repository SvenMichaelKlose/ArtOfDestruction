draw_line:
.(
    lda x1      ; dx = x1 - x0
    sec
    sbc x0
    sta dx
    asl
    sta sm1+1

    lda y1      ; dy = y1 - y0
    sec
    sbc y0
    asl
    sta dy

    sec         ; D = 2*dy - dx
    sbc dx
    sta line_d

    ldx x0
    ldy y0
    jsr draw_pixel

loop:
    cpx x1
    beq done
    inx
    lda line_d
    beq n1      ; D = 0
    bmi n1      ; D < 0
    iny
    jsr draw_pixel
    lda dy
    sec
sm1:sbc #0
    jmp add_to_d
n1: jsr draw_pixel
    lda dy      ; D = D + 2dy
add_to_d:
    clc
    adc line_d
    sta line_d
    jmp loop
done:
    rts
.)
