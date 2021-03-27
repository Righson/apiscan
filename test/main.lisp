(defpackage apiscan/test/main
  (:use :cl :apiscan :rove))

(in-package :apiscan/test/main)

(deftest test-add
  (testing "add 2 and 2"
    (let ((a 2) (b 2))
      (ok (= 4 (+ a b))))))
