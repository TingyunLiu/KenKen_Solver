;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname kenken) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************************************
;;     Tingyun Liu (20552650)
;;     CS 135 Winter 2015
;;     Assignment 10, Problem 1 (kenken)
;; *************************************************************************
;;

(require "kenken-draw.rkt")

;; From kenken-start

(define-struct puzzle (size board constraints))
;; A Puzzle is a (make-puzzle 
;;                Nat 
;;                (listof (listof (anyof Sym Nat Guess))
;;                (listof (list Sym Nat (anyof '+ '- '* '/ '=))))
;; requires: See Assignment Specifications

(define-struct guess (symbol number))
;; A Guess is a (make-guess Sym Nat)
;; requires: See Assignment Specifications

;; Some useful constants
;; from assignment specification
(define puzzle1
  (make-puzzle 
   4
   (list
    (list 'a 'b 'b 'c)
    (list 'a 'd 'e 'e)
    (list 'f 'd 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'd 5 '+)
    (list 'e 3 '-)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1
(define puzzle1partial
  (make-puzzle 
   4
   (list
    (list 'a 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1 with a cage partially filled in
(define puzzle1partial2
  (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1 with a cage partially filled in
;; but not yet verified 
(define puzzle1partial3
  (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) 'b 'b 'c)
    (list (make-guess 'a 3) 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

(define puzzle1partial4
  (make-puzzle 
   4
   (list
    (list 'a 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 (make-guess 'g 2) (make-guess 'g 1))
    (list 'f 'h 'i 'i))
   (list
    (list 'g 2 '/)
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'h 4 '=)
    (list 'i 1 '-))))

(define puzzle1partial5
  (make-puzzle 
   4
   (list
    (list 'a (make-guess 'b 1) (make-guess 'b 4) 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'b 3 '-)
    (list 'g 2 '/)
    (list 'a 6 '*)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; The solution to puzzle 1
(define puzzle1soln
  (make-puzzle
   4
   '((2 1 4 3)
     (3 2 1 4)
     (4 3 2 1)
     (1 4 3 2))
   empty))

;; wikipedia KenKen example
(define puzzle2
  (make-puzzle
   6
   '((a b b c d d)
     (a e e c f d)
     (h h i i f d)
     (h h j k l l)
     (m m j k k g)
     (o o o p p g))
   '((a 11 +)
     (b 2 /)
     (c 20 *)
     (d 6 *)
     (e 3 -)
     (f 3 /)
     (g 9 +)
     (h 240 *)
     (i 6 *)
     (j 6 *)
     (k 7 +)
     (l 30 *)
     (m 6 *)
     (o 8 +)
     (p 2 /))))

;; a partial solution to puzzle2 with a cage partially filled in
;; but not yet verified 
(define puzzle2partial
  (make-puzzle
   6
   (list (list 'a 'b 'b 'c (make-guess 'd 1) (make-guess 'd 3))
         (list 'a 'e 'e 'c 'f (make-guess 'd 1))
         (list 'h 'h 'i 'i 'f (make-guess 'd 2))
         '(h h 1 2 l l)
         '(m m 6 1 4 g)
         '(o o o p p g))
   '((d 6 *)
     (a 11 +)
     (b 2 /)
     (c 20 *)
     (e 3 -)
     (f 3 /)
     (g 9 +)
     (h 240 *)
     (i 6 *)
     (l 30 *)
     (m 6 *)
     (o 8 +)
     (p 2 /))))

;; Wrong guesses
(define puzzle2partial2
  (make-puzzle
   6
   (list (list (make-guess 'a 2) 'b 'b 'c 'd 'd)
         (list (make-guess 'a 6) 'e 'e 'c 'f 'd)
         '(h h i i f d)
         '(h h 1 2 l l)
         '(m m 6 1 4 g)
         '(o o o p p g))
   '((a 11 +)
     (b 2 /)
     (c 20 *)
     (d 6 *)
     (e 3 -)
     (f 3 /)
     (g 9 +)
     (h 240 *)
     (i 6 *)
     (l 30 *)
     (m 6 *)
     (o 8 +)
     (p 2 /))))

;; The solution to puzzle 2
(define puzzle2soln
  (make-puzzle
   6
   '((5 6 3 4 1 2)
     (6 1 4 5 2 3)
     (4 5 2 3 6 1)
     (3 4 1 2 5 6)
     (2 3 6 1 4 5)
     (1 2 5 6 3 4))
   empty))

;; Tiny board
(define puzzle3
  (make-puzzle 
   2 
   '((a b) 
     (c b)) 
   '((b 3 +) 
     (c 2 =)
     (a 1 =))))

(define puzzle3partial
  (make-puzzle
   2 
   (list
    (list 'a (make-guess 'b 1))
    (list 'c (make-guess 'b 2)))
   '((b 3 +) 
     (c 2 =)
     (a 1 =))))  

;; Wrong guesses
(define puzzle3partial2
  (make-puzzle
   2 
   (list
    (list 'a (make-guess 'b 2))
    (list 'c (make-guess 'b 2)))
   '((b 3 +) 
     (c 2 =)
     (a 1 =))))  

(define puzzle3partial3
  (make-puzzle
   2 
   (list
    (list (make-guess 'a 1) 'b)
    (list 'c 'b))
   '((a 1 =)
     (b 3 +) 
     (c 2 =)))) 

;; The solution to puzzle3
(define puzzle3soln
  (make-puzzle 
   2 
   '((1 2) 
     (2 1))
   empty))

;; a big board:  will take a *long* time without trying the bonus
(define puzzle4
  (make-puzzle
   9
   '((a a b c d e e f f)
     (g h b c d i j k l)
     (g h m m i i j k l)
     (n o m p p q q r s)
     (n o t u p v v r s)
     (n w t u x x y z z)
     (A w B C C C y D D)
     (A B B E E F G H I)
     (J J K K F F G H I))
   '((a 2 /)
     (b 11 +)
     (c 1 -)
     (d 7 *)
     (e 4 -)
     (f 9 +)
     (g 1 -)
     (h 4 /)
     (i 108 *)
     (j 13 +)
     (k 2 -)
     (l 5 -)
     (m 84 *)
     (n 24 *)
     (o 40 *)
     (p 18 *)
     (q 2 /)
     (r 2 -)
     (s 13 +)
     (t 10 +)
     (u 13 +)
     (v 2 -)
     (w 63 *)
     (x 1 -)
     (y 3 /)
     (z 2 /)
     (A 7 +)
     (B 13 +)
     (C 336 *)
     (D 1 -)
     (E 15 +)
     (F 12 *)
     (G 9 +)
     (H 5 -)
     (I 18 *)
     (J 3 /)
     (K 40 *))))

;;==============================================================================
;; Part (a)

;; (find-blank puz) produces the position of the first blank
;; space in puz, or false if no cells are blank.  If the first constraint has
;; only guesses on the board, find-blank produces 'guess.  
;; find-blank: Puzzle -> (anyof Posn false 'guess)
;; Examples:
(check-expect (find-blank puzzle1) (make-posn 0 0))
(check-expect (find-blank puzzle1partial3) 'guess)
(check-expect (find-blank puzzle1soln) false)

(define (find-blank puz)
  (cond 
    [(empty? (puzzle-constraints puz)) false]
    [else
     (local [;; (find-blank/acc brd sym current-pos) produces the position of 
             ;;   the sym in lolst based on current-position if sym appears 
             ;;   in brd, otherwise produces 'guess
             ;; find-blank/acc: (listof (listof (anyof Sym Nat Guess))) Sym Posn 
             ;; -> Posn
             (define (find-blank/acc brd sym current-pos)
               (cond
                 [(empty? brd) 'guess]
                 [(and (symbol? (first (first brd)))
                       (symbol=? sym (first (first brd))))
                  current-pos]
                 [(member? sym (first brd))
                  (find-blank/acc (list (rest (first brd)))
                                  sym (make-posn (add1 (posn-x current-pos))
                                                 (posn-y current-pos)))]
                 [else (find-blank/acc (rest brd) sym
                                       (make-posn (posn-x current-pos)
                                                  (add1 (posn-y current-pos))))]))]
       
       (find-blank/acc (puzzle-board puz)
                       (first (first (puzzle-constraints puz)))
                       (make-posn 0 0)))]))

;; Tests:
(check-expect (find-blank puzzle2soln) false)
(check-expect (find-blank puzzle2partial) 'guess) 
(check-expect (find-blank puzzle1partial2) (make-posn 0 1))
(check-expect (find-blank puzzle3) (make-posn 1 0))
(check-expect (find-blank puzzle3partial) 'guess)

;;==============================================================================
;; Part (b)

;; (used-in-row puz pos) produces a list of numbers used in the same 
;; row as (x,y) position, pos, in the given puz.  
;; used-in-row: Puzzle Posn -> (listof Nat)
;; Examples:
(check-expect (used-in-row puzzle1 (make-posn 1 1)) empty)
(check-expect (used-in-row puzzle1partial (make-posn 2 2)) (list 3))
(check-expect (used-in-row puzzle1partial2 (make-posn 0 1)) (list 1 2 4))

(define (used-in-row puz pos)
  (quicksort (foldr 
              (lambda (x y) (cond [(guess? x) (cons (guess-number x) y)]
                                  [(number? x) (cons x y)]
                                  [else y]))
              empty
              (list-ref (puzzle-board puz) (posn-y pos))) <))

;; Tests:
(check-expect (used-in-row puzzle2 (make-posn 3 5)) empty)
(check-expect (used-in-row puzzle1partial3 (make-posn 0 0)) (list 2))
(check-expect (used-in-row puzzle1partial3 (make-posn 3 0)) (list 2))
(check-expect (used-in-row puzzle2soln (make-posn 3 4)) (list 1 2 3 4 5 6))

;; (used-in-column puz pos) produces a list of numbers used in the same
;; column as (x,y) position, pos, in the given puz.  
;; used-in-column: Puzzle Posn -> (listof Nat)
;; Examples:
(check-expect (used-in-column puzzle1 (make-posn 1 1)) empty)
(check-expect (used-in-column puzzle1partial (make-posn 2 2)) (list 1))
(check-expect (used-in-column puzzle1partial2 (make-posn 0 1)) (list 2))

(define (used-in-column puz pos)
  (quicksort (foldr 
              (lambda (x y) (cond [(guess? x) (cons (guess-number x) y)]
                                  [(number? x) (cons x y)]
                                  [else y]))
              empty
              (map (lambda (x) (list-ref x (posn-x pos))) (puzzle-board puz))) <))

;; Tests:
(check-expect (used-in-column puzzle2 (make-posn 2 3)) empty)
(check-expect (used-in-column puzzle1partial3 (make-posn 0 1)) (list 2 3))
(check-expect (used-in-column puzzle1partial3 (make-posn 0 3)) (list 2 3))
(check-expect (used-in-column puzzle2soln (make-posn 5 2)) (list 1 2 3 4 5 6))

;;==============================================================================
;; Part (c)

;;This function may be useful as a helper for available-vals

;; (allvals n) produces a list of values from 1 to n
;; allvals: Nat -> (listof Nat)
;; Examples:
(check-expect (allvals 0) empty)
(check-expect (allvals 1) (list 1))

(define (allvals n) (build-list n (lambda (x) (add1 x))))

;; Tests:
(check-expect (allvals 2) (list 1 2))
(check-expect (allvals 3) (list 1 2 3))
(check-expect (allvals 4) (list 1 2 3 4))

;; (available-vals puz pos) produces a list of valid entries for the (x,y)  
;; position, pos, of the consumed puzzle, puz.  
;; available-vals: Puzzle Posn -> (listof Nat)
;; Examples:
(check-expect (available-vals puzzle1 (make-posn 2 3)) '(1 2 3 4))
(check-expect (available-vals puzzle1partial3 (make-posn 0 3)) '(1 4))

(define (available-vals puz pos)
  (filter (lambda (x) (not (member? x (append (used-in-row puz pos)
                                              (used-in-column puz pos)))))
          (allvals (puzzle-size puz))))

;; Tests:
(check-expect (available-vals puzzle2 (make-posn 4 1)) '(1 2 3 4 5 6))
(check-expect (available-vals puzzle1partial (make-posn 2 2)) '(2 4))
(check-expect (available-vals puzzle1partial2 (make-posn 0 1)) '(3))
(check-expect (available-vals puzzle1partial2 (make-posn 2 2)) '(2 4))
(check-expect (available-vals puzzle1partial3 (make-posn 2 0)) '(3 4))
(check-expect (available-vals puzzle1partial3 (make-posn 0 1)) empty)
(check-expect (available-vals puzzle1soln (make-posn 2 3)) empty)

;;==============================================================================
;; Part (d)

;; (place-guess brd pos val) fills in the (x,y) position, pos, of the board, brd, 
;; with the a guess with value, val
;; place-guess: (listof (listof (anyof Sym Nat Guess))) Posn Nat 
;;              -> (listof (listof (anyof Sym Nat Guess)))
;; requires: the given pos contains a symbol
;; Examples:
(check-expect (place-guess (puzzle-board puzzle1) (make-posn 0 0) 3)
              (list
               (list (make-guess 'a 3) 'b 'b 'c)
               (list 'a 'd 'e 'e)
               (list 'f 'd 'g 'g)
               (list 'f 'h 'i 'i)))
(check-expect (place-guess (puzzle-board puzzle1) (make-posn 2 3) 1)
              (list
               (list 'a 'b 'b 'c)
               (list 'a 'd 'e 'e)
               (list 'f 'd 'g 'g)
               (list 'f 'h (make-guess 'i 1) 'i)))

(define (place-guess brd pos val)
  (cond
    [(zero? (posn-y pos)) 
     (local
       [;; (guess-val/x los x val) fills in the x position in los with the a
        ;;   guess with value, val
        ;; guess-val/x: (listof Sym) Nat Nat
        (define (guess-val/x los x val)
          (cond
            [(zero? x) (cons (make-guess (first los) val) (rest los))]
            [else (cons (first los) (guess-val/x (rest los) (sub1 x) val))]))]
       
       (cons (guess-val/x (first brd) (posn-x pos) val) (rest brd)))]
    [else (cons (first brd) 
                (place-guess (rest brd) (make-posn (posn-x pos)
                                                   (sub1 (posn-y pos))) val))]))

;; Tests:
(check-expect (place-guess (puzzle-board puzzle1) (make-posn 3 0) 4)
              (list
               (list 'a 'b 'b (make-guess'c 4))
               (list 'a 'd 'e 'e)
               (list 'f 'd 'g 'g)
               (list 'f 'h 'i 'i)))
(check-expect (place-guess (puzzle-board puzzle1) (make-posn 0 2) 3)
              (list
               (list 'a 'b 'b 'c)
               (list 'a 'd 'e 'e)
               (list (make-guess 'f 3) 'd 'g 'g)
               (list 'f 'h 'i 'i)))
(check-expect (place-guess (puzzle-board puzzle1) (make-posn 1 2) 2)
              (list
               (list 'a 'b 'b 'c)
               (list 'a 'd 'e 'e)
               (list 'f (make-guess 'd 2) 'g 'g)
               (list 'f 'h 'i 'i)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DO NOT CHANGE THIS FUNCTION;;;;;;;;;;;;;;;;;;;;;;;

;; (fill-in-guess puz pos val) fills in the (x,y) position, pos, of puz's board
;; with a guess wtih value, val
;; fill-in-guess: Puzzle Posn Nat -> Puzzle
;; Examples:
(check-expect (fill-in-guess puzzle1 (make-posn 3 2) 5)
              (make-puzzle
               4
               (list
                (list 'a 'b 'b 'c)
                (list 'a 'd 'e 'e)
                (list 'f 'd 'g (make-guess 'g 5))
                (list 'f 'h 'i 'i))
               (puzzle-constraints puzzle1)))

(define (fill-in-guess puz pos val)
  (make-puzzle (puzzle-size puz) 
               (place-guess (puzzle-board puz) pos val) 
               (puzzle-constraints puz)))

;; Tests:
(check-expect (fill-in-guess puzzle3 (make-posn 0 0) 1)
              (make-puzzle
               2
               (list (list (make-guess 'a 1) 'b)
                     (list 'c 'b))
               '((b 3 +) 
                 (c 2 =)
                 (a 1 =))))

;;==============================================================================
;; Part (e)

;; (guess-valid? puz) determines if the guesses in puz satisfy their constraint
;; guess-valid?: Puzzle -> Bool
;; Examples:
(check-expect (guess-valid? puzzle2partial) true)
(check-expect (guess-valid? puzzle2partial2) false)

(define (guess-valid? puz)
  (local
    [(define first-constraints-opr (third (first (puzzle-constraints puz))))]
    
    (= (foldr 
        (cond
          [(symbol=? '+ first-constraints-opr) +]
          [(symbol=? '- first-constraints-opr) -]
          [(symbol=? '* first-constraints-opr) *]
          [(symbol=? '/ first-constraints-opr) /]
          [(symbol=? '= first-constraints-opr) (lambda (x y) (+ x y))])
        (cond
          [(or (symbol=? '* first-constraints-opr)
               (symbol=? '/ first-constraints-opr)) 1]
          [else 0])
        (quicksort (map guess-number 
                        (foldr 
                         (lambda (x y) (append (filter guess? x) y)) 
                         empty (puzzle-board puz))) >))
       (second (first (puzzle-constraints puz))))))

;; Tests:
(check-expect (guess-valid? puzzle1partial3) true)
(check-expect (guess-valid? puzzle1partial4) true)
(check-expect (guess-valid? puzzle1partial5) true)
(check-expect (guess-valid? puzzle3partial) true)
(check-expect (guess-valid? puzzle3partial2) false)
(check-expect (guess-valid? puzzle3partial3) true)

;;==============================================================================
;; Part (f)

;; (apply-guess puz) converts all guesses in puz into their corresponding numbers
;; and removes the first contraint from puz's list of contraints
;; apply-guess:  Puzzle -> Puzzle
;; requires: all the guesses are valid 
;; Examples:
(check-expect (apply-guess puzzle3partial)
              (make-puzzle
               2 
               (list
                (list 'a 1)
                (list 'c 2))
               '((c 2 =)
                 (a 1 =)))) 
(check-expect (apply-guess puzzle3partial3)
              (make-puzzle
               2 
               (list
                (list 1 'b)
                (list 'c 'b))
               '((b 3 +) 
                 (c 2 =)))) 

(define (apply-guess puz)
  (make-puzzle
   (puzzle-size puz)
   (foldr (lambda (x y)
            (cons (map (lambda (z)
                         (cond [(guess? z) (guess-number z)]
                               [else (identity z)])) x) y))
          empty
          (puzzle-board puz))
   (rest (puzzle-constraints puz))))

;; Tests:
(check-expect (apply-guess puzzle1partial3)
              (make-puzzle 
               4
               (list
                (list 2 'b 'b 'c)
                (list 3 2 1 4)
                (list 'f 3 'g 'g)
                (list 'f 'h 'i 'i))
               (list
                (list 'b 3 '-)
                (list 'c 3 '=)
                (list 'f 3 '-)
                (list 'g 2 '/)
                (list 'h 4 '=)
                (list 'i 1 '-))))
(check-expect (apply-guess puzzle1partial4)
              (make-puzzle 
               4
               (list
                (list 'a 'b 'b 'c)
                (list 'a 2 1 4)
                (list 'f 3 2 1)
                (list 'f 'h 'i 'i))
               (list
                (list 'a 6 '*)
                (list 'b 3 '-)
                (list 'c 3 '=)
                (list 'f 3 '-)
                (list 'h 4 '=)
                (list 'i 1 '-))))
(check-expect (apply-guess puzzle2partial)
              (make-puzzle
               6
               (list (list 'a 'b 'b 'c 1 3)
                     (list 'a 'e 'e 'c 'f 1)
                     (list 'h 'h 'i 'i 'f 2)
                     '(h h 1 2 l l)
                     '(m m 6 1 4 g)
                     '(o o o p p g))
               '((a 11 +)
                 (b 2 /)
                 (c 20 *)
                 (e 3 -)
                 (f 3 /)
                 (g 9 +)
                 (h 240 *)
                 (i 6 *)
                 (l 30 *)
                 (m 6 *)
                 (o 8 +)
                 (p 2 /))))

;;==============================================================================
;; Part (g)

;; (neighbours puz) produces a list of next puzzles after puz in
;; the implicit graph
;; neighbours: Puzzle -> (listof Puzzle)
;; Examples:
(check-expect (neighbours puzzle2soln) empty)
(check-expect (neighbours puzzle2partial2) empty)
(check-expect (neighbours puzzle3partial)
              (list 
               (make-puzzle
                2 
                (list
                 (list 'a 1)
                 (list 'c 2))
                '((c 2 =)
                  (a 1 =)))))
(check-expect (neighbours puzzle3)
              (list 
               (make-puzzle 
                2 
                (list 
                 (list 'a (make-guess 'b 1)) 
                 (list 'c 'b)) 
                '((b 3 +) 
                  (c 2 =)
                  (a 1 =)))
               (make-puzzle 
                2 
                (list 
                 (list 'a (make-guess 'b 2)) 
                 (list 'c 'b)) 
                '((b 3 +) 
                  (c 2 =)
                  (a 1 =)))))

(define (neighbours puz)
  (local
    [(define first-blank (find-blank puz))]
    
    (cond 
      [(and (symbol? first-blank) (guess-valid? puz))
       (list (apply-guess puz))]
      [(posn? first-blank)
       (foldr (lambda (x y) (cons (fill-in-guess puz first-blank x) y))
              empty
              (available-vals puz first-blank))]
      [else empty])))

;; Tests:
(check-expect (neighbours puzzle1soln) empty)
(check-expect (neighbours puzzle3partial2) empty)
(check-expect (neighbours puzzle3partial3)
              (list
               (make-puzzle
                2
                '((1 b)
                  (c b))
                '((b 3 +)
                  (c 2 =)))))
(check-expect (neighbours puzzle1partial2)
              (list
               (make-puzzle 
                4
                (list
                 (list (make-guess 'a 2) 'b 'b 'c)
                 (list (make-guess 'a 3) 2 1 4)
                 (list 'f 3 'g 'g)
                 (list 'f 'h 'i 'i))
                (list
                 (list 'a 6 '*)
                 (list 'b 3 '-)
                 (list 'c 3 '=)
                 (list 'f 3 '-)
                 (list 'g 2 '/)
                 (list 'h 4 '=)
                 (list 'i 1 '-)))))
(check-expect (neighbours puzzle1partial4)
              (list
               (make-puzzle 
                4
                (list
                 (list 'a 'b 'b 'c)
                 (list 'a 2 1 4)
                 (list 'f 3 2 1)
                 (list 'f 'h 'i 'i))
                (list
                 (list 'a 6 '*)
                 (list 'b 3 '-)
                 (list 'c 3 '=)
                 (list 'f 3 '-)
                 (list 'h 4 '=)
                 (list 'i 1 '-)))))
(check-expect (neighbours puzzle1)
              (list
               (make-puzzle 
                4
                (list
                 (list (make-guess 'a 1) 'b 'b 'c)
                 (list 'a 'd 'e 'e)
                 (list 'f 'd 'g 'g)
                 (list 'f 'h 'i 'i))
                (list
                 (list 'a 6 '*)
                 (list 'b 3 '-)
                 (list 'c 3 '=)
                 (list 'd 5 '+)
                 (list 'e 3 '-)
                 (list 'f 3 '-)
                 (list 'g 2 '/)
                 (list 'h 4 '=)
                 (list 'i 1 '-)))
               (make-puzzle 
                4
                (list
                 (list (make-guess 'a 2) 'b 'b 'c)
                 (list 'a 'd 'e 'e)
                 (list 'f 'd 'g 'g)
                 (list 'f 'h 'i 'i))
                (list
                 (list 'a 6 '*)
                 (list 'b 3 '-)
                 (list 'c 3 '=)
                 (list 'd 5 '+)
                 (list 'e 3 '-)
                 (list 'f 3 '-)
                 (list 'g 2 '/)
                 (list 'h 4 '=)
                 (list 'i 1 '-)))
               (make-puzzle 
                4
                (list
                 (list (make-guess 'a 3) 'b 'b 'c)
                 (list 'a 'd 'e 'e)
                 (list 'f 'd 'g 'g)
                 (list 'f 'h 'i 'i))
                (list
                 (list 'a 6 '*)
                 (list 'b 3 '-)
                 (list 'c 3 '=)
                 (list 'd 5 '+)
                 (list 'e 3 '-)
                 (list 'f 3 '-)
                 (list 'g 2 '/)
                 (list 'h 4 '=)
                 (list 'i 1 '-)))
               (make-puzzle 
                4
                (list
                 (list (make-guess 'a 4) 'b 'b 'c)
                 (list 'a 'd 'e 'e)
                 (list 'f 'd 'g 'g)
                 (list 'f 'h 'i 'i))
                (list
                 (list 'a 6 '*)
                 (list 'b 3 '-)
                 (list 'c 3 '=)
                 (list 'd 5 '+)
                 (list 'e 3 '-)
                 (list 'f 3 '-)
                 (list 'g 2 '/)
                 (list 'h 4 '=)
                 (list 'i 1 '-)))))

;; This is just the find-route function from Module 12, slides
;; 31-37.  (Read a bit ahead if you want the deatils.) The explicit
;; graph G has been removed, and the termination condition (the desired
;; destination) is when the puzzle is complete (that is, find-blank
;; returns false).

;; (solve-kenken orig draw-option) finds the solution to a KenKen puzzle,
;; orig, or returns false if there is no solution.  A visual representiation
;; of the solution may be draw depending on the value of draw-option
;; solve-kenken: Puzzle Sym -> (anyof Puzzle false)
;; requires:  draw-option is one of 'off, 'norm, 'slow, 'fast
;; Examples:
(check-expect (solve-kenken puzzle1 'off) puzzle1soln)
(check-expect (solve-kenken puzzle2partial 'off) false)

(define (solve-kenken orig draw-option)
  (local
    [(define setup (puzzle-setup orig draw-option))
     (define (solve-kenken-helper to-visit visited)
       (cond
         [(empty? to-visit) false]
         [else (local
                 [(define draw (draw-board (first to-visit) draw-option))]
                 (cond
                   [(boolean? (find-blank (first to-visit))) (first to-visit)]
                   [(member (first to-visit) visited)
                    (solve-kenken-helper (rest to-visit) visited)]
                   [else
                    (local [(define nbrs (neighbours (first to-visit)))
                            (define new (filter (lambda (x) (not (member x visited))) nbrs))
                            (define new-to-visit (append new (rest to-visit)))
                            (define new-visited (cons (first to-visit) visited))]
                      (solve-kenken-helper new-to-visit new-visited))]))]))]
    (solve-kenken-helper (list orig) empty)))

;; Tests:
(check-expect (solve-kenken puzzle3partial 'off) false)
(check-expect (solve-kenken puzzle1partial2 'off) puzzle1soln)
(check-expect (solve-kenken puzzle1partial3 'off) puzzle1soln)
(check-expect (solve-kenken puzzle3 'off) puzzle3soln)
(check-expect (solve-kenken puzzle1 'fast) puzzle1soln)

;; The time special form shows you the number of milliseconds spent
;; evaluating the given expression.  The first number (cpu time) is
;; the important one.
(check-expect (time (solve-kenken puzzle1 'off)) puzzle1soln)
(check-expect (time (solve-kenken puzzle2 'off)) puzzle2soln) 
(check-expect (time (solve-kenken puzzle3 'off)) puzzle3soln)