#lang racket/base
(require racket/string)
(require racket/contract)

(module+ test
  (require rackunit))

; convert a function to only contain alphanumerics and dashes
(define (normalize s)
  (define lowercase (string-downcase s)) ; convert the string to lower case
  (define replaced (string-replace lowercase ; replace any non-alphanumeric numbers with a dash
                                   #rx"[^a-z0-9]+"
                                   "-"))
  (define trimmed (string-trim replaced #rx"-+")) ; remove any leading/trailing dashes
  trimmed)
(provide (contract-out [normalize (-> string? string?)]))
(module+ test
  (check-equal? (normalize "abc") "abc"
                "no special characters")
  (check-equal? (normalize "Abc") "abc"
                "to lower case")
  (check-equal? (normalize "abc|d") "abc-d"
                "remove special characters")
  (check-equal? (normalize "! abc def !") "abc-def"
                "remove leading/trailing dashes"))

