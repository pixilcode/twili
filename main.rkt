#lang racket/base
(require "store.rkt")

(load-from-yaml)
(save-to-yaml (load-from-yaml))
; run this
