#lang racket/base
(require racket/contract)
(require gregor)
(require "util.rkt")

; struct
(struct task (name
              group
              unique-id
              due-date
              complete?)
  #:transparent)

; constructor
(define (make-task name group day month year [complete? #f])
  (define normalized-name (normalize name))
  (define normalized-group (normalize group))
  (define unique-id
    (string-append normalized-name "-" normalized-group))
  (define due-date (date year month day))
  (task name group unique-id due-date complete?))
  
(provide (struct-out task)
         make-task)
