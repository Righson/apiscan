;;;; apiscan.lisp

(in-package #:apiscan)

(ql:quickload :drakma)

(defvar *environment* '())

(defun set-env-params! (param value)
  (setq *environment* (append *environment* (list param value))))

(defun keyword->string (kwrd)
  (string-downcase (string kwrd)))

(defun list->pairs (lst)
  (let ((frst (car  lst))
        (scnd (cadr lst)))
    (if (null scnd)
        nil
        (cons (list frst scnd) (list->pairs (cddr lst))))))

(defun params-list->string (params-lst)
  (let* ((frst (car params-lst))
         (f (keyword->string (first frst)))
         (s (second frst)))
    (if (not (null (rest params-lst)))
        (format nil "~A=~A&~A" f s (params-list->string (rest params-lst)))
        (format nil "~A=~A" f s))))

(defun make-caller-http (url) (lambda (method)
                                (drakma:http-request (format nil "http://~A/~A" url method))))
(defun make-caller-http-with-params (url) (lambda (method params)
                                            (drakma:http-request (format nil "http://~A/~A?~A" url method
                                                    (params-list->string (list->pairs params))))))

(defun call-api (url)
  (dra))

(defun make-urls (api-answer path)
  )

(defun get-in (col path)
  (let ((path-element (first path)))
    (if (and (listp col)
             (eq (first col) path-element))
        (if (null (rest path))
            (rest col)
            (get-in (first (rest col)) (rest path)))
        nil)))
