(declare-datatypes (a b)
  ((pair :source |Prelude.(,)|
     (pair2 :source |Prelude.(,)| (proj1-pair a) (proj2-pair b)))))
(declare-datatypes (a)
  ((list :source |Prelude.[]| (nil :source |Prelude.[]|)
     (cons :source |Prelude.:| (head a) (tail (list a))))))
(declare-datatypes ()
  ((B :source Graph.B (I :source Graph.I) (O :source Graph.O))))
(define-fun-rec
  primEnumFromTo :source Prelude.primEnumFromTo
    ((x Int) (y Int)) (list Int)
    (ite (> x y) (_ nil Int) (cons x (primEnumFromTo (+ 1 x) y))))
(define-fun-rec
  or2 :let :source Prelude.or
    ((x (list Bool))) Bool
    (match x
      (case nil false)
      (case (cons y xs) (or y (or2 xs)))))
(define-fun-rec
  (par (t)
    (maximum-maximum1 :let :source Graph.maximum
       ((x t) (y (list (pair t t)))) t
       (match y
         (case nil x)
         (case (cons z yzs)
           (match z
             (case (pair2 y2 z2)
               (maximum-maximum1
                 (let ((y3 (ite (<= y2 z2) z2 y2))) (ite (<= x y3) y3 x))
                 yzs))))))))
(define-fun-rec
  (par (a)
    (length :source Prelude.length
       ((x (list a))) Int
       (match x
         (case nil 0)
         (case (cons y l) (+ 1 (length l)))))))
(define-fun-rec
  (par (t)
    (last :source Graph.last
       ((x t) (y (list t))) t
       (match y
         (case nil x)
         (case (cons z ys) (last z ys))))))
(define-fun-rec
  dodeca6 :let
    ((x Int) (y (list Int))) (list (pair Int Int))
    (match y
      (case nil (_ nil (pair Int Int)))
      (case (cons z x2)
        (cons (pair2 (+ (+ (+ x x) x) z) (+ (+ (+ x x) x) (+ 1 z)))
          (dodeca6 x x2)))))
(define-fun-rec
  dodeca5 :let
    ((x Int) (y (list Int))) (list (pair Int Int))
    (match y
      (case nil (_ nil (pair Int Int)))
      (case (cons z x2)
        (cons (pair2 (+ (+ x x) z) (+ (+ (+ x x) x) z)) (dodeca5 x x2)))))
(define-fun-rec
  dodeca4 :let
    ((x Int) (y (list Int))) (list (pair Int Int))
    (match y
      (case nil (_ nil (pair Int Int)))
      (case (cons z x2)
        (cons (pair2 (+ x (+ 1 z)) (+ (+ x x) z)) (dodeca4 x x2)))))
(define-fun-rec
  dodeca3 :let
    ((x Int) (y (list Int))) (list (pair Int Int))
    (match y
      (case nil (_ nil (pair Int Int)))
      (case (cons z x2)
        (cons (pair2 (+ x z) (+ (+ x x) z)) (dodeca3 x x2)))))
(define-fun-rec
  dodeca2 :let
    ((x Int) (y (list Int))) (list (pair Int Int))
    (match y
      (case nil (_ nil (pair Int Int)))
      (case (cons z x2) (cons (pair2 z (+ x z)) (dodeca2 x x2)))))
(define-fun-rec
  dodeca :let
    ((x (list Int))) (list (pair Int Int))
    (match x
      (case nil (_ nil (pair Int Int)))
      (case (cons y z) (cons (pair2 y (+ 1 y)) (dodeca z)))))
(define-fun-rec
  bin :source Graph.bin
    ((x Int)) (list B)
    (ite
      (= x 0) (_ nil B)
      (let ((md (mod x 2)))
        (ite
          (=
            (ite
              (and
                (= (ite (= x 0) 0 (ite (<= x 0) (- 0 1) 1))
                  (ite (<= 2 0) (- 0 (- 0 1)) (- 0 1)))
                (distinct md 0))
              (- md 2) md)
            0)
          (cons O (bin (div x 2))) (cons I (bin (div x 2)))))))
(define-fun-rec
  bgraph :let :source Graph.bgraph
    ((x (list (pair Int Int)))) (list (pair (list B) (list B)))
    (match x
      (case nil (_ nil (pair (list B) (list B))))
      (case (cons y z)
        (match y
          (case (pair2 u v) (cons (pair2 (bin u) (bin v)) (bgraph z)))))))
(define-fun-rec
  beq :source Graph.beq
    ((x (list B)) (y (list B))) Bool
    (match x
      (case nil
        (match y
          (case nil true)
          (case (cons z x2) false)))
      (case (cons x3 xs)
        (match x3
          (case I
            (match y
              (case nil false)
              (case (cons x4 ys)
                (match x4
                  (case I (beq xs ys))
                  (case O false)))))
          (case O
            (match y
              (case nil false)
              (case (cons x5 zs)
                (match x5
                  (case I false)
                  (case O (beq xs zs))))))))))
(define-fun-rec
  bpath :let
    ((x (list B)) (y (list B)) (z (list (pair (list B) (list B)))))
    (list Bool)
    (match z
      (case nil (_ nil Bool))
      (case (cons x2 x3)
        (match x2
          (case (pair2 u v)
            (cons (or (and (beq u x) (beq v y)) (and (beq u y) (beq v x)))
              (bpath x y x3)))))))
(define-fun-rec
  bpath2 :source Graph.bpath
    ((x (list (list B))) (y (list (pair (list B) (list B))))) Bool
    (match x
      (case nil true)
      (case (cons z x2)
        (match x2
          (case nil true)
          (case (cons y2 xs) (and (or2 (bpath z y2 y)) (bpath2 x2 y)))))))
(define-fun-rec
  belem :let
    ((x (list B)) (y (list (list B)))) (list Bool)
    (match y
      (case nil (_ nil Bool))
      (case (cons z x2) (cons (beq x z) (belem x x2)))))
(define-fun
  belem2 :source Graph.belem
    ((x (list B)) (y (list (list B)))) Bool (or2 (belem x y)))
(define-fun-rec
  bunique :source Graph.bunique
    ((x (list (list B)))) Bool
    (match x
      (case nil true)
      (case (cons y xs) (and (not (belem2 y xs)) (bunique xs)))))
(define-fun
  btour :source Graph.btour
    ((x (list (list B))) (y (list (pair Int Int)))) Bool
    (match x
      (case nil
        (match y
          (case nil true)
          (case (cons z x2) false)))
      (case (cons x3 x4)
        (match y
          (case nil false)
          (case (cons x5 vs)
            (match x5
              (case (pair2 u v)
                (and (beq x3 (last x3 x4))
                  (and (bpath2 x (bgraph y))
                    (and (bunique x4)
                      (= (length x)
                        (ite
                          (<= u v) (+ 1 (+ 1 (maximum-maximum1 v vs)))
                          (+ 1 (+ 1 (maximum-maximum1 u vs)))))))))))))))
(define-fun-rec
  (par (a)
    (++ :source Prelude.++
       ((x (list a)) (y (list a))) (list a)
       (match x
         (case nil y)
         (case (cons z xs) (cons z (++ xs y)))))))
(define-fun
  dodeca7 :source Graph.dodeca
    ((x Int)) (list (pair Int Int))
    (ite
      (= x 0) (_ nil (pair Int Int))
      (++ (cons (pair2 (- x 1) 0) (dodeca (primEnumFromTo 0 (- x 1))))
        (++ (dodeca2 x (primEnumFromTo 0 x))
          (++ (dodeca3 x (primEnumFromTo 0 x))
            (++
              (cons (pair2 x (+ (+ x x) (- x 1)))
                (dodeca4 x (primEnumFromTo 0 (- x 1))))
              (++ (dodeca5 x (primEnumFromTo 0 x))
                (cons (pair2 (+ (+ (+ x x) x) (- x 1)) (+ (+ x x) x))
                  (dodeca6 x (primEnumFromTo 0 (- x 1)))))))))))
(prove
  :source Graph.prop_bt3
  (forall ((p (list (list B))))
    (not
      (btour p
        (++ (cons (pair2 (- 3 1) 0) (dodeca (primEnumFromTo 0 (- 3 1))))
          (++ (dodeca2 3 (primEnumFromTo 0 3))
            (++ (dodeca3 3 (primEnumFromTo 0 3))
              (++
                (cons (pair2 3 (+ (+ 3 3) (- 3 1)))
                  (dodeca4 3 (primEnumFromTo 0 (- 3 1))))
                (++ (dodeca5 3 (primEnumFromTo 0 3))
                  (cons (pair2 (+ (+ (+ 3 3) 3) (- 3 1)) (+ (+ 3 3) 3))
                    (dodeca6 3 (primEnumFromTo 0 (- 3 1)))))))))))))
