(apply #'assemble-files "aod.prg"
      '("zeropage.asm"
        "bender/vic-20/vic.asm"
        "bender/vic-20/basic-loader.asm"
        "opcodes.asm"

        "init.asm"
        "lowmem-start.asm"
          "sky_and_ground.asm"
          "char.asm"
          "screen.asm"
          "blitter.asm"
          "bits.asm"
          "math.asm"
          "multiply.asm"
          "divide.asm"
          "sin.asm"
          "sinetab.asm"
        "lowmem-end.asm"
        "init-end.asm"

        "main.asm"
        "polygon.asm"
        "world.asm"))

(make-vice-commands "aod.vice.txt")
(quit)
