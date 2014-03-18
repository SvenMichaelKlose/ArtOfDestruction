smtab_increment:
    .byte opcode_inx, opcode_iny
    .byte opcode_dex, opcode_iny
    .byte opcode_dex, opcode_dey
    .byte opcode_inx, opcode_dey

smtab_step:
    .byte opcode_iny, opcode_inx
    .byte opcode_dey, opcode_inx
    .byte opcode_dey, opcode_dex
    .byte opcode_iny, opcode_dex

octant = tmp

draw_line:
.(
    lda #0
    sta octant

    lda x1      ; dx = x1 - x0
    sec
    sbc x0
    bcc p1
    inc octant
    jsr neg
p1: sta dx
    asl
    sta sm1+1

    asl octant

    lda y1      ; dy = y1 - y0
    sec
    sbc y0
    bcc p2
    inc octant
    jsr neg
p2: asl
    sta dy

    asl octant

    lda dx
    cmp dy
    bcc no_swap
    inc octant
    ldx dx
    ldy dy
    sty dx
    sta dy
    lda #opcode_cpy
    sta loop
    lda #y1
    sta loop+1

no_swap:

    lda dy
    sec         ; D = 2*dy - dx
    sbc dx
    sta line_d

    ldx octant
    lda smtab_increment,x
    sta increment
    lda smtab_step,x
    sta step

    ldx x0
    ldy y0
    jsr draw_pixel

loop:
    cpx x1
    beq done
increment:
    inx
    lda line_d
    beq n1      ; D = 0
    bmi n1      ; D < 0
step:
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
