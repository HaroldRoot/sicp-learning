(print "What's your name")

(finish-output) ; ˢ�������

(defvar *name* (read))

(defun hello-you (*name*)
    (format t "Hello ~a! ~%" *name*)
)

;;; (setq *print-case* :capitalize)

(hello-you *name*)