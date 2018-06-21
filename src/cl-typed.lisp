;; cl-typed - A project template generated by ahungry-fleece
;; Copyright (C) 2016 Your Name <cl-typed@example.com>
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU Affero General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU Affero General Public License for more details.
;;
;; You should have received a copy of the GNU Affero General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;;; cl-typed.lisp

(in-package #:cl-user)

(defpackage cl-typed
  (:use :cl :cl-annot)
  (:export :main
           :!
           :defn
           :print-usage))

(in-package #:cl-typed)

;; (defn add-reals (real real → real) (a b) (+ a b))

;; (defmacro fun (types &rest rest)
;;   `(defn ,types ,(cadr rest) ,@(cddr rest)))

(annot:enable-annot-syntax)
(setf (annot.core:annotation-inline-p 'annot) t)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro defn (types name args &rest rest)
    "Type safe defun"
    (let ((types (remove-if
                  (lambda (x) (or (equal '-> x) (equal '→ x))) types)))
      `(progn (defun ,name ,args
                ,@(loop
                     for arg in args
                     for type in types
                     collect `(check-type ,arg ,type))
                ,@rest)
              (declaim (ftype (function ,(butlast types) ,@(last types)) ,name)))))

  (defannotation ! (x y)
      (:arity 2 :inline t)
    `(defn ,x ,(cadr y) ,@(cddr y))))

@! (number number → number)
(defun add (a b)
  (print "I will never print, even with invalid inputs at runtime.")
  (+ a b))

(defun broken-call () (add "x" "y"))

(defun add-x (a b)
  (print "I will happily print, even with invalid inputs at runtime.")
  (+ a b))

(defun broken-call-x () (add-x "x" "y"))

(defun print-usage ()
  (format t
          "cl-typed v/~a.

Usage:

    $ cl-typed [-h, --help] # Print this help

"
          (asdf:component-version (asdf:find-system :cl-typed))))

(defun main (&rest argv)
  (unless argv
    (setf argv (cdr sb-ext:*posix-argv*)))

  (if (or (equal (first argv) "-h")
          (equal (first argv) "--help"))
      (print-usage)

      (cond
        (t (print-usage)))))

;;; "cl-typed" goes here. Hacks and glory await!
