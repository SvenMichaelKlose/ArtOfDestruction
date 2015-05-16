realstart   = @(+ #x1000 charsetsize)

    sei
    lda #$7f
    sta $912e       ; Disable and acknowledge interrupts.
    sta $912d
    sta $911e       ; Disable restore key NMIs.

init_lowmem:
    ldx #0
l:  lda lowmem,x
    sta $200,x
    lda @(+ lowmem 256),x
    sta $300,x
    dex
    bne -l

    lda #vic_charset_1000
    sta vicreg_screenhi_charset

    jmp main
