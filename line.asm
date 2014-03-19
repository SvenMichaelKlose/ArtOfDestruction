; https://en.wikipedia.org/wiki/Bresenham_line

smtab_increment:
    .byte opcode_inx, opcode_iny
    .byte opcode_inx, opcode_dey
    .byte opcode_dex, opcode_iny
    .byte opcode_dex, opcode_dey

smtab_step:
    .byte opcode_iny, opcode_inx
    .byte opcode_dey, opcode_inx
    .byte opcode_iny, opcode_dex
    .byte opcode_dey, opcode_dex

octant = tmp

draw_line:
.(
    lda #0
    sta octant
    lda #opcode_cpx
    sta test
    lda #x1
    sta test+1

    lda x1      ; dx = x1 - x0
    sec
    sbc x0
    bpl p1
    inc octant  ; Tell to decrement X.
    jsr neg
p1: sta dx

    asl octant
    lda y1      ; dy = y1 - y0
    sec
    sbc y0
    bpl p2
    inc octant  ; Tell to decrement Y.
    jsr neg
p2: sta dy

    asl octant
    lda dx
    cmp dy
    bcs no_swap
    inc octant  ; Tell to swap X and Y.
    ldx dx
    ldy dy
    sty dx
    stx dy
    lda #opcode_cpy
    sta test
    lda #y1
    sta test+1
no_swap:

    lda dy
    asl
    sta dy
    sec         ; D = 2*dy - dx
    sbc dx
    sta line_d

    lda dx
    asl
    sta update+1

    ldx octant
    lda smtab_increment,x
    sta increment
    lda smtab_step,x
    sta step

    ldx x0
    ldy y0

loop:
    jsr draw_pixel
test:
    cpx x1
    beq done
increment:
    inx
    lda line_d
    beq n1      ; D = 0
    bmi n1      ; D < 0
step:
    iny
    lda dy      ; D = D + (2dy - 2dx)
    sec
update:
    sbc #0
    jmp add_to_d
n1: lda dy      ; D = D + 2dy
add_to_d:
    clc
    adc line_d
    sta line_d
    jmp loop
done:
    rts
.)
