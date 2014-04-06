numchars    = 128
charset     = $1000

charsetsize         = numchars * 8
charsetmask         = numchars-1

s                       = $00
d                       = $02
c                       = $04
scr                     = $04
col                     = $06
scrx                    = $08
scry                    = $09
curcol                  = $0a

char_x                  = $0b
char_y                  = $0c
x0                      = $0d
x1                      = $0e
y0                      = $0f
y1                      = $10
dx                      = $11
dy                      = $12
line_d                  = $13

tmp                     = $14
tmp2                    = $15
next_char               = $16

result_decimals         = $18
result                  = $19
product                 = $1a
denominator             = product
counter                 = $1b
save_x                  = $1c
save_y                  = $1d


slope_left_decimals     = $1e
slope_left              = $1f
slope_right_decimals    = $20
slope_right             = $21

x_left_decimals         = $22
x_left                  = $23
x_right_decimals        = $24
x_right                 = $25
x_bottom_left           = $26
x_bottom_right          = $27
y_top                   = $28
y_bottom_left           = $29
y_bottom_right          = $2a

x_char_left_decimals    = $2b
x_char_left             = $2c
x_char_right_decimals   = $2d
x_char_right            = $2e

width                   = $2f
height                  = $30
height_left             = $31
height_right            = $32
rows                    = $33
charline                = $34
