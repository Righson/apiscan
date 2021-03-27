;;;; apiscan.asd

(asdf:defsystem #:apiscan
  :description "Describe apiscan here"
  :author "Your Name <your.name@example.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:drakma #:flexi-streams #:cl-json)
  :components ((:file "package")
              (:file "apiscan"))
  :in-order-to ((test-op (test-op #:apiscan/test))))

(asdf:defsystem #:apiscan/test
  :description "Test module"
  :author "Me"
  :licence "MIT"
  :version "0.0.1"
  :depends-on (#:apiscan #:rove)
  :components ((:module "test"
                :components
                ((:file "main"))))
  :perform (test-op (op c) (symbol-call :rove :run c)))
