#lang racket/base
(require racket/cmdline)
(require (prefix-in ui: "ui.rkt"))
(require (prefix-in store: "store.rkt"))

(define action
  (command-line
    #:program "twili"

    #:args (action)

    action))

(define tasks (store:load-from-yaml "test.yaml"))
tasks

#|
(case action
  [("list") (ui:list-all tasks)])
|#

