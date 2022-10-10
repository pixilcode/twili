#lang racket/base
(require yaml)
(require "model.rkt")

(define default-yaml-file "test.yaml")

(define (hash->task hash)
  (define name (hash-ref hash "name"))
  (define due-date (hash-ref hash "due-date"))
  (define complete? (hash-ref hash "complete"))
  (task name due-date complete?))

(define (task->hash task)
  (make-hash
   (list
    (cons "name" (task-name task))
    (cons "due-date" (task-due-date task))
    (cons "complete" (task-complete? task)))))

(define (load-from-yaml [file-loc default-yaml-file])
  (define file-input (file->yaml "test.yaml"))
  (define groups
    (hash-map/copy file-input
                   (lambda (group-name task-list)
                     (values group-name (map hash->task task-list)))))
  (group groups))

(define (save-to-yaml groups [file-loc default-yaml-file])
  (define groups-hash
    (hash-map/copy (group-list groups)
                   (lambda (group-name task-list)
                     (values group-name (map task->hash task-list)))))
  (write-yaml groups-hash
              (open-output-file file-loc #:exists 'truncate/replace)
              #:style 'block))

(provide load-from-yaml save-to-yaml)
