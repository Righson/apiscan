;;;; apiscan.asd

(asdf:defsystem #:apiscan
  :description "Describe apiscan here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:drakma #:flexi-streams #:cl-json)
  :components ((:file "package")
               (:file "apiscan")))
