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

(deftest test-scan-in
  (testing "scan-in should return nil if collection is empty"
    (ok (null (scan-in '() :c))))
  (testing "scan-in should returln list in next case"
    (ok (= (list 4 "qwe")
           (scan-in '(((:a . 4)(:b . 99))
                      ((:a . "qwe")(:b . 99))) :a)))))
