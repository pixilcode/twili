#lang racket/base
(require racket/contract)
(require gregor)
(require "model.rkt")

(module+ test
  (require rackunit)
  (define test-tasks (list (make-task
                            "task a"
                            "group-1"
                            (->year (today))
                            (->month (today))
                            (->day (today))
                            #f)
                           (make-task
                            "task b"
                            "group-1"
                            (->year (today))
                            (->month (today))
                            (->day (today))
                            #f))))
  
; add a task to the given group
(define (add-task tasks new-task)
  (append tasks (list new-task)))

; remove a task from a given group
(define (remove-task tasks unique-id)
  (remove
   unique-id
   tasks
   (lambda (unique-id task) (equal?
                             unique-id
                             (task-unique-id task)))))

; list the tasks for a given group
(define (list-group-tasks tasks group)
  (filter
   (lambda (task) (equal? group (task-group task)))
   tasks))


; list all tasks by group
(define (list-all-tasks tasks) tasks)

(provide (contract-out
          [add-task (-> (listof task?) task? (listof task?))]
          [remove-task (-> (listof task?) string? (listof task?))]
          [list-group-tasks (-> (listof task?) string? (listof task?))]
          [list-all-tasks (-> (listof task?) (listof task?))]))
(module+ test
  (check-equal? 1 2))