;;;; apiscan.lisp

(in-package #:apiscan)

(ql:quickload :drakma)
(ql:quickload :flexi-streams)

(defparameter *environment* (make-hash-table))
(defparameter *host* "")

(defun call-api (url)
  (with-input-from-string
      (s (flexi-streams:octets-to-string (drakma:http-request url)))
    (json:decode-json s)))


(defun set-env-params! (param value)
  (setf (gethash param *environment*) (list value))
  *environment*)

(defun set-host! (host)
  (setq *host* host))

(defun keyword->string (kwrd)
  (string-downcase (string kwrd)))

(defun list->pairs (lst)
  (let ((frst (car  lst))
        (scnd (cadr lst)))
    (if (null scnd)
        nil
        (cons (list frst scnd) (list->pairs (cddr lst))))))

(defun params-list (hash)
  (let ((ret ""))
    (maphash #'(lambda (k v)
                 (let ((ks (keyword->string k))
                       (vs (first v)))
                   (if (= 0 (length ret))
                       (setq ret (format nil "~A=~A" ks vs))
                       (setq ret (format nil "~A&~A=~A" ret ks vs))))) hash)
    ret))


(defun make-caller-http (url)
  (lambda (method)
    (let ((u (format nil "http://~A/~A" url method)))
      (call-api u))))

(defun make-caller-http-with-params (url)
  (lambda (method params)
    (let ((u (format nil "http://~A/~A?~A" url method (params-list params))))
      (call-api u))))


(defun make-urls! (method col keys)
  (mapcar
   (lambda (x)
     (format nil "~A/~A/?~A"
             *host*
             method
             (params-list (set-env-params! (first keys) x))))
   col))

(defun scan (col key)
  (let* ((f (first col))
         (k (first f))
         (n (rest col)))
         (if (eq key k) (cdr f)
             (if (null n)
                 nil
                 (scan n key)))))

(defun scan-in (col find &optional acc)
  (let ((el (scan (first col) find)))
    (if (null el)
        acc
        (scan-in (rest col) find (append acc (list el))))))

;; ;; (mapcar #'parse-integer (scan-in cache :code '()))
