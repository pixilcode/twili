#lang racket/base

(struct task (name due-date complete?) #:transparent)
(provide (struct-out task))

(struct group (list) #:transparent)
(provide (struct-out group))
