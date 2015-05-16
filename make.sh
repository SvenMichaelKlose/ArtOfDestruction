#!/bin/sh

tre make-sinetab.lisp
sbcl --core bender/bender make.lisp
