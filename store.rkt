#lang racket/base
(require yaml)
(require racket/list)
(require "model.rkt")

(define default-yaml-file "test.yaml")

; task/hash conversions
(define (task->hash task)
  (define due-date
    (string-append (number->string (task-due-date-year task))
                   "-"
                   (number->string (task-due-date-month task))
                   "-"
                   (number->string (task-due-date-day task))))
  (make-hash
    (list
      (cons "name" (task-name task))
      (cons "due-date" due-date)
      (cons "complete" (task-complete? task)))))

(define (hash->task group-name)
  (lambda (task-hash)
    (define name (hash-ref task-hash "name"))
    (define due-date (hash-ref task-hash "due-date"))
    (define complete? (hash-ref task-hash "complete"))
    (make-task name
               group-name
               (date-day due-date)
               (date-month due-date)
               (date-year due-date)
               complete?)))

; load/save yaml
(define (load-from-yaml [file-loc default-yaml-file])
  (define file-input (file->yaml "test.yaml"))
  (define tasks
    (flatten (for/list ([(group-name task-list) (in-hash file-input)])
               (map (hash->task group-name) task-list))))
  tasks)

(define (save-to-yaml task-list [file-loc default-yaml-file])
  (define grouped-tasks (group-by task-group task-list))
  (define grouped-tasks-hash (make-hash (map (lambda (tasks-group)
                                               (displayln tasks-group)
                                               (cons (task-group (first tasks-group))
                                                     (map task->hash tasks-group)))
                                             grouped-tasks)))
  (write-yaml grouped-tasks-hash
              (open-output-file file-loc #:exists 'truncate/replace)
              #:style 'block))

(provide load-from-yaml save-to-yaml)
