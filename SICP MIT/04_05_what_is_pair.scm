(define (cons a b)
    (lambda (pick)
        (cond ((= pick 1) a)
              ((= pick 2) b))))

(define (car x) (x 1))

(define (cdr x) (x 2))

(car (cons 37 49)) ; 37

(define a (cons 37 49)) ; #[compound-procedure 12]
