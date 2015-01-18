#lang racket
; VARIABLES ======================
;define an easy sudoku board
(define sudoku 
  '(
    (0 2 5 0 0 1 0 0 0)
    (1 0 4 2 5 0 0 0 0)
    (0 0 6 0 0 4 2 1 0)
    (0 5 0 0 0 0 3 2 0)
    (6 0 0 0 2 0 0 0 9)
    (0 8 7 0 0 0 0 6 0)
    (0 9 1 5 0 0 6 0 0)
    (0 0 0 0 7 8 1 0 3)
    (0 0 0 6 0 0 5 9 0)
    ) 
)

;define the alternative values
(define sudokuAltValues '(1 2 3 4 5 6 7 8 9))
; VARIABLES ====================== END

; SOLVE ======================

(define (remove-repetition my-list value)
   (if (null? my-list)
       '()
       (cons (if (equal? (length (car my-list)) 1)
                    (car my-list)
                    (remove value (car my-list))) 
             (remove-repetition (cdr my-list) value)))
  )

;this finds only one singleton in the row
(define (findSingleton myList count)
  (if (null? myList)
      '()
      (if (eq? (length (car myList)) 1)
          (car myList);(cons (car myList) count)
          (findSingleton (cdr myList) (+ count 1))))
 )

;This finds all singletons in an the row
(define (find-all-singletons my-list count)
  (cond
    [(null? my-list) '()]
    [(equal? (length (car my-list)) 1) (cons (cons (caar my-list) count) (find-all-singletons (cdr my-list) (+ count 1)))]
    [else (find-all-singletons (cdr my-list) (+ count 1))])
 )


; SOLVE ====================== END

; TRANSFORM ======================
;This recursive function replaces all 0 for a given list and other numbers is replace 
;for a list containing the singleton number
(define (addList myList newList)
  (if (null? myList) 
       '()
       ;when the list is not empty, make a new list
       (cons        
        (if (zero? (car myList))
            ;replace any zero value for new list
            newList
            ;create a new list containing the value is not zero
            (cons (car myList) '()))
        ;send the cdr to the same function to find if it has zeros
        (addList (cdr myList) newList)))
  )

;---- WORK IN PROGRESS - NOT SURE TAIL RECURSIVE IS THE BEST WAY -------
;This recursive function replaces all 0 for a given list and other numbers is replace 
;for a list containing the singleton number
#;(define (addList myList newList listSoFar)
  (if (null? myList) 
       listSoFar
       ;when the list is not empty, make a new list
       (addList (cdr myList) newList (cons 
                                       listSoFar
                                       (if (zero? (car myList))
                                           (cons newList '())
                                           (cons (car myList) '())) 
                                        )))
  )

;this recursive function replaces each integer with all the alternative solutions
(define (transform sudoku sudokuList)
  (if (null? sudoku)
      '()
      ;create a new list with the values change to list
      (cons
       ;replace all the zeros for list with possible answers
       (addList (car sudoku) sudokuList)
       (transform (cdr sudoku) sudokuList)
       ))
  )
; TRANSFORM ====================== END

(define (sudoku-row matrix)
  (if (null? matrix)
      '()
      (cons (remove-repetition (car matrix) (if (null? (findSingleton (car matrix) 0))
                                                0
                                                (car (findSingleton (car matrix) 0)))) 
            (sudoku-row (cdr matrix))))
  )

 (define (thisone my-list row)
     (cond
       [(null? my-list) row]
       [else (thisone (cdr my-list) (remove-from-location row (car my-list) 0))] 
      )
   )

#;(define (sudoku-row-2 matrix)
  (cond
    [(null? matrix) '()]
    [(null? (find-all-singletons (car matrix))) (remove-from-location (car matrix) () 0)]
    [else (cons (car matrix) (sudoku-row-2 (cdr matrix)))]
    )
  )

(define transformed-matrix (transform sudoku sudokuAltValues))
;(sudoku-row transformed-matrix)

;############### REMOVES FROM THE COLUMN ###############
;This one removes a found singleton from a spec
(define (remove-from-location row value counter)
    (cond 
      [(null? row) '()]
      [(and (equal? counter (cdr value)) (> (length (car row)) 1)) (cons (remove-number (car row) (car value) 0) (remove-from-location (cdr row) value (+ counter 1)))]
      [else (cons (car row) (remove-from-location (cdr row) value (+ counter 1)))]
      )
    )

(define (remove-number this-list number counter)
  (cond
    [(null? this-list) '()]
    [(eq? (car this-list) number) (remove-number (cdr this-list) number (+ counter 1))]    
    [else (cons (car this-list) (remove-number (cdr this-list) number (+ counter 1)))] 
    )    
  )

;############### REMOVES FROM THE COLUMN END ###############
;############### REMOVES FROM MATRIX  ###############
#;(define (remove-form-box matrix row column value)
  (cons
   ;
   [() ()]
   [() ()]
   [else ()])
  
  )
