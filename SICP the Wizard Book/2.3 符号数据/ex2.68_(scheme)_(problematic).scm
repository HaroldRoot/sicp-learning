(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_representing_huffman_trees.scm")
(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_sets_of_weighted_elements.scm")
(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_the_decoding_procedure.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append 
       (encode-symbol (car message) 
                      tree)
       (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (define (iter result current-node)
    (cond ((eq? symbol
                (symbol-leaf (left-branch current-node)))
           (reverse (cons 0 result)))
          ((leaf? (right-branch current-node))
           (if (eq? symbol (symbol-leaf (right-branch current-node)))
               (reverse (cons 1 result))
               (error "bad symbol: ITER" symbol)))
          (else (iter (cons 1 result)
                      (right-branch current-node)))))
  (iter '() tree))

(define sample-tree
  (make-code-tree 
   (make-leaf 'A 4)
   (make-code-tree
    (make-leaf 'B 2)
    (make-code-tree 
     (make-leaf 'D 1)
     (make-leaf 'C 1)))))

;;; 测试
(encode '(A D A B B C A) sample-tree)
;Value: (0 1 1 0 0 1 0 1 0 1 1 1 0)

(encode '(A) sample-tree)
;Value: (0)

(encode '(C) sample-tree)
;Value: (1 1 1)