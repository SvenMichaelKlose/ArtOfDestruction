reuse_char:
    lda curcol
    sta (col),y
    txa

get_char_addr:
    sta tmp
    asl
    asl
    asl
    sta d
    lda tmp
    lsr
    lsr
    lsr
    lsr
    lsr
    ora #>charset
    sta d+1
    rts

alloc_wrap:
    lda #0
    jmp fetch_char

alloc_char:
    lda next_char
    beq alloc_wrap
    lda next_char
    inc next_char

fetch_char:
.(
    and #charsetmask
    pha
    jsr get_char_addr
    jsr blit_clear_char
    pla
    iny
    rts
.)

test_position:
.(
    lda scrx
    cmp #22
    bcs e
    lda scry
    cmp #23
e:  rts
.)

get_char:
.(
    jsr test_position
    bcs cant_use_position
    jsr scrcoladdr
    lda (scr),y
    bne reuse_char
    jsr alloc_char
    sta (scr),y
    lda curcol
    sta (col),y
    rts
cant_use_position:
    lda #$f0
    sta d+1
    rts
.)
