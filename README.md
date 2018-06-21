# cl-typed - Strong static typing for Common Lisp

## Usage

Simple math example:

```lisp
(ql:quickload :cl-typed)
(use-package :cl-typed)
(annot:enable-annot-syntax)

@! (number number → number)
(defun add (a b)
  (print "I will never print, even with invalid inputs at runtime.")
  (+ a b))

(defun broken-call () (add "x" "y")) ;; Will not compile

(defun add-x (a b)
  (print "I will happily print, even with invalid inputs at runtime.")
  (+ a b))

(defun broken-call-x () (add-x "x" "y")) ;; Will compile with just a warning
```

## Testing

Build with `cat build.sh | sh` in the project root.

Then you can use a simple `make test` in the future to test changes.

To run tests in the REPL: `(ql:quickload :cl-typed) (cl-typed.run.tests:main)`

## TODO

I'll probably look into making a lot of custom types, so a typable collection would
enable something such as:

```lisp
@! (numbers → number)
(defun summer (a)
  (reduce #'+ a))
```

Such that it will error out if compiled or called with an input list
that was not all numeric etc.

## License
GPLv3
