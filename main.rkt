#lang racket
(require yaml)

(struct task (name due-date complete?) #:transparent)

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

(define file-input (file->yaml "test.yaml"))

(define (classes-hash->classes-tasks classes)
  (hash-map/copy classes
                 (lambda (class-name task-list)
                   (values class-name (map hash->task task-list)))))

(define (classes-tasks->classes-hash classes)
  (hash-map/copy classes
                 (lambda (class-name task-list)
                   (values class-name (map task->hash task-list)))))

(classes-hash->classes-tasks file-input)
(classes-tasks->classes-hash (classes-hash->classes-tasks file-input))
(write-yaml (classes-tasks->classes-hash (classes-hash->classes-tasks file-input)))