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

;;;; cl-typed.lib.stub.lisp

(in-package #:cl-user)

(defpackage cl-typed.lib.stub
  (:use :cl :cl-annot)
  (:export
   :!
   :defn
   :echo))

(in-package #:cl-typed.lib.stub)

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

(defun echo (input)
  input)

;;; "cl-typed.lib.stub" goes here. Hacks and glory await!
