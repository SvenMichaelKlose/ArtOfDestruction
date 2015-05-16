    asl
    ldx #0
    lda #tank_rotation_top
    jsr make_tank_point
    lda #tank_rotation_top
    jsr make_tank_point
    ldx #0              ; Copy two points for the back.
    ldy #4
    jsr copy_point
    jsr copy_point
    ldx #0              ; Copy and half ground points for the top.
l:  jsr half
    cpy #10
    bne l
    ldx #6              ; Copy halveds for top.
    jsr copy_point
    jsr copy_point
    lda tank_rotation_top
    lda #tank_cannon_angle ; Make outer point for the cannon.
    jsr calc_circle_point
    ldx #13             ; Make inner point for cannon.
    jsr half
    dex                 ; Copy two points for the cannon.
    ldy #15
    jsr copy_point
    jsr copy_point
    rts

make_tank_point:
    clc
    adc #tank_angle_top
    ldy #tank_diameter_top
    jsr calc_circle_point
    lda points_x,x
    jsr neg
    sta points_x+2,y
    lda points_z,x
    jsr neg
    sta points_z+2,y
    rts

half:
    lda points_x,x
    asl
    sta points_x+2,y
    lda points_z,x
    asl
    sta points_z+2,y
    rts

calc_circle_point:
    sty result
    pha
    jsr sinmul
    sta points_x,x

    sty result
    pla
    jsr cosmul
    sta points_z,x

    inx
    rts
