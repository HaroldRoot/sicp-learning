;;;; 费马检查耗时测试

#||
修改 ex1.22 的 timed-prime-test 过程，
让它使用 fast-prime?（费马方法）。
费马检查具有 O(log n) 的增长速度，
将接近 1,000,000 的素数检查
与接近 1,000 的素数检查所用时间做对比。
||#

#|---------------------------------------------------------------|#

;;; ex1.23_3_new_sm_search_more.scm

(define (next-odd n) (if (odd? n) (+ 2 n) (+ 1 n)))

(define (search-for-primes n goal)
    (cond ((= goal 0) 
            (display "Search complete.")
            (newline)
            true)
          ((fast-prime? n 100) ; 修改这里
            (display n)
            (display ", ")
            (search-for-primes (next-odd n) (- goal 1)))
          (else
            (search-for-primes (next-odd n) goal))))

(define (timed-prime-test n)
    (newline)
    (display "起点为 ")
    (display n)
    (display "，开始寻找素数……")
    (newline)
    (start-prime-test n (real-time-clock)))

(define (start-prime-test n start-time)
    (if (search-for-primes n 50) 
        (report-prime (- (real-time-clock) start-time))))

(define (report-prime elapsed-time)
    (display "总计用时：")
    (display elapsed-time))

#|---------------------------------------------------------------|#

;;; eg1.2.6_fermat_test.scm

(define (expmod base exp m) 
    (cond ((= exp 0) 1) 
          ((even? exp) 
           (remainder (square (expmod base (/ exp 2) m)) m)) 
           (else  
            (remainder (* base (expmod base (- exp 1) m)) m)))) 

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a)) 
    (try-it (+ 1 (random (- n 1))))) 

(define (fast-prime? n times)
    (cond ((= times 0) true) 
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else false))) 

#|---------------------------------------------------------------|#

(timed-prime-test 1000)
#||
起点为 1000，开始寻找素数……
1009, 1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097, 1103, 1105, 1109, 1117, 1123, 1129, 1151, 1153, 1163, 1171, 1181, 1187, 1193, 1201, 1213, 1217, 1223, 1229, 1231, 1237, 1249, 1259, 1277, 1279, 1283, 1289, 1291, 1297, 1301, 1303, 1307, 1319, 1321, 1327, Search complete.
总计用时：57
||#

(timed-prime-test 10000)
#||
起点为 10000，开始寻找素数……
10007, 10009, 10037, 10039, 10061, 10067, 10069, 10079, 10091, 10093, 10099, 10103, 10111, 10133, 10139, 10141, 10151, 10159, 10163, 10169, 10177, 10181, 10193, 10211, 10223, 10243, 10247, 10253, 10259, 10267, 10271, 10273, 10289, 10301, 10303, 10313, 10321, 10331, 10333, 10337, 10343, 10357, 10369, 10391, 10399, 10427, 10429, 10433, 10453, 10457, Search complete.
总计用时：75
||#

(timed-prime-test 100000)
#||
起点为 100000，开始寻找素数……
100003, 100019, 100043, 100049, 100057, 100069, 100103, 100109, 100129, 100151, 100153, 100169, 100183, 100189, 100193, 100207, 100213, 100237, 100267, 100271, 100279, 100291, 100297, 100313, 100333, 100343, 100357, 100361, 100363, 100379, 100391, 100393, 100403, 100411, 100417, 100447, 100459, 100469, 100483, 100493, 100501, 100511, 100517, 100519, 100523, 100537, 100547, 100549, 100559, 100591, Search complete.
总计用时：96
||#

(timed-prime-test 1000000)
#||
起点为 1000000，开始寻找素数……
1000003, 1000033, 1000037, 1000039, 1000081, 1000099, 1000117, 1000121, 1000133, 1000151, 1000159, 1000171, 1000183, 1000187, 1000193, 1000199, 1000211, 1000213, 1000231, 1000249, 1000253, 1000273, 1000289, 1000291, 1000303, 1000313, 1000333, 1000357, 1000367, 1000381, 1000393, 1000397, 1000403, 1000409, 1000423, 1000427, 1000429, 1000453, 1000457, 1000507, 1000537, 1000541, 1000547, 1000577, 1000579, 1000589, 1000609, 1000619, 1000621, 1000639, Search complete.
总计用时：116
||#

#||
116/57=2.035...
从 n=1,000 到 n=1,000,000，耗时只增长到原来的两倍。
符合预期！（费马检查具有 O(log n) 的增长速度）
||#