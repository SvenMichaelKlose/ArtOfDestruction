realstart   = $1000 + charsetsize

    cli
    lda #$7f
    sta $912e       ; Disable and acknowledge interrupts.
    sta $912d
    sta $911e       ; Disable restore key NMIs.

    lda #vic_charset_1000
    sta vicreg_screenlo_charset

    jmp main
