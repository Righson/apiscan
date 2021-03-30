(defpackage apiscan/test/main
  (:use :cl :apiscan :rove))

(in-package :apiscan/test/main)

(deftest test-keyword->string
    (testing "keyword->string should convert :key to lowercase string"
             (ok (string= "test" (keyword->string :test)))))

(deftest test-scan
  (testing "scan should return correct list"
    (ok (equal '(3) (scan '((:b 4) (:a 3)) :a))))
  (testing "scan should return nil if element did't find"
    (ok (null (scan '((:b 4)) :c)))))
