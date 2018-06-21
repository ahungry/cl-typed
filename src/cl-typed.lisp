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
  (:use :cl)
  (:export :main
           :print-usage))

(in-package #:cl-typed)

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
