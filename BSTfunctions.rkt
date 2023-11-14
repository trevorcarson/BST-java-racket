#lang racket

(require "BST.rkt")
(provide height)
(provide find-min)
(provide in-order)
(provide delete)


;; height: returns the height of a BST
;;   input: a BST
;;   output: the number of edges on the longest path from the root to a leaf
(define (height tree)
  (cond [(emptyTree? tree) -1]
        [(leaf? tree) 0]
        [(+ 1 (max(height (rightTree tree)) (height (leftTree tree))))]))

;; find-min: returns the smallest element in a non-empty BST
;;   input: a non-empty BST
;;   outputs: the smallest number in the tree
(define (find-min tree)
  (cond [(leaf? tree) (key tree)]
        [(find-min (leftTree tree))]))
      


;; in-order: returns an ordered list of the elements in a BST
;;   input: a BST
;;   outputs: a list of all the elements in the BST, in increasing order
(define (in-order tree)
  (cond [(emptyTree? tree) '()]
        [(append (in-order (leftTree tree))
                 (list (key tree))
                 (in-order (rightTree tree)))]))


;; insertWrong: incorrectly inserts an element into a BST
;;   inputs: an element e to insert and a BST
;;   output: a new BST with e inserted
(define (insertWrong e tree)
  (cond [(emptyTree? tree)
         (make-BST-leaf e)]
        [(= e (key tree)) ; already have the element
         tree]
        [(< e (key tree)) ; insert to the LEFT
         (insertWrong e (leftTree tree))]
        [else             ; insert to the RIGHT
         (insertWrong e (rightTree tree))]
        ))


;; insert: inserts an element into a BST
;;   inputs: an element e to insert and a BST
;;   output: a new BST with e inserted
(define (insert e tree)
  (cond [(emptyTree? tree)
         (make-BST-leaf e)]
        [(= e (key tree)) ; already have the element
         tree]
        [(< e (key tree)) ; insert to the LEFT
         (make-BST (key tree)
                   (insert e (leftTree tree))
                   (rightTree tree))]
        [else             ; insert to the RIGHT
         (make-BST (key tree)
                   (leftTree tree)
                   (insert e (rightTree tree)))]
        ))


;; delete: removes an element from a BST
;;   input: an element e to delete and a BST
;;   outputs: a new BST with e removed (if e appears in the tree)

(define (delete e tree)
  (cond [(emptyTree? tree)
         tree] ; Key not found
        [(< e (key tree)) ; key in left subtree
         (make-BST (key tree)
               (delete e (leftTree tree))
               (rightTree tree))]
        [(> e (key tree)) ;key in right subtree
         (make-BST (key tree)
               (leftTree tree)
               (delete e (rightTree tree)))]
        [else ;assumes we found e
         (cond [(emptyTree? (leftTree tree))
                (rightTree tree)] ; Case 1: Node has only right child or is a leaf
               [(emptyTree? (rightTree tree))
                (leftTree tree)] ; Case 2: Node has only left child
               [else
                (let* ((min-right (find-min (rightTree tree)))
                       (new-right (delete min-right (rightTree tree))))
                  (make-BST min-right (leftTree tree) new-right))])])) ; Case 3: Node has two children
               











                           
        