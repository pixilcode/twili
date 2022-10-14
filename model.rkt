#lang racket/base
(require racket/contract)

; Structs
(struct task (name due-date complete?) #:transparent)
(provide (struct-out task))

(struct group (list) #:transparent)
(provide (struct-out group))

; Getters
(define (group-task-list group group-name)
    (hash-ref (group-list group) group-name))

; Actions
(module* actions #f
  ; add a task to the given group
  (define (add-task target-group group-name task)
    (define new-task-list
      (append
       (group-task-list target-group group-name)
       (list task)))
    (group (hash-set
            (group-list target-group)
            group-name
            new-task-list)))

  ; remove a task from a given group
  (define (remove-task target-group group-name target-task-name)
    (define new-task-list
      (remove
       target-task-name
       (group-task-list target-group group-name)
       (lambda (name task) (equal? name (task-name task)))))
    (group (hash-set
            (group-list target-group)
            group-name
            new-task-list)))

  ; list the tasks for a given group
  (define list-group-tasks group-task-list)

  ; list all tasks by group
  (define list-all-tasks group-list)

  (provide (contract-out
            [add-task (-> group? string? task? group?)]
            [list-group-tasks (-> group? string? (listof task?))]
            [list-all-tasks (-> group? hash?)])))
    