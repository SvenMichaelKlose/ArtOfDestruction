(defvar steps 256)

(with-queue q
  (do ((i 0 (+ i (/ 360 steps))))
      ((<= (/ 360 4) i))
    (enqueue q (string (integer (* 128 (degree-sin i))))))
  (with-output-file o "sinetab.asm"
    (format o "sinetab:~%")
    (adolist ((group (queue-list q) 8))
      (format o "    .byte ~A~%" (apply #'+ (pad ! ", "))))))
(quit)
