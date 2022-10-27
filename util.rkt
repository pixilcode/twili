#lang racket/base
(require racket/string)
(require racket/contract)

(module+ test
  (require rackunit))

; convert a function to only contain alphanumerics and dashes
(define (normalize string)
  (string-trim
   (string-replace
    (string-downcase string) ; 1. convert the string to lower case
    #rx"[^a-z0-9]+" ; 2. replace any non-alphanumeric numbers...
    "-") ; ...with a dash
   #rx"-+")) ; 3. remove any leading/trailing dashes
(provide (contract-out [normalize (-> string string)]))
(module+ test
  (check-equal? (normalize "abc") "abc"
                "no special characters")
  (check-equal? (normalize "Abc") "abc"
                "to lower case")
  (check-equal? (normalize "abc|d") "abc-d"
                "remove special characters")
  (check-equal? (normalize "! abc def !") "abc-def"
                "remove leading/trailing dashes"))

