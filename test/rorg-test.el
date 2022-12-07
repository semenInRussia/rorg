;; -*- lexical-binding: t -*-

(require 'ert)
(require 'rorg)

(ert-deftest rorg-test-heading-level
    ()
  (with-temp-buffer
    (insert "*** Ye!")
    (should (= (rorg--heading-level) 3))
    ;;
    (erase-buffer)
    (insert "Ye!")
    (should-not (rorg--heading-level))))

(ert-deftest rorg-test-heading-level-in-region
    ()
  (with-temp-buffer
    (insert "* A
* B
* C")
    (mark-whole-buffer)
    (should
     (=
      (rorg--heading-level-in-region (region-beginning) (region-end))
      1))
    ;;
    (erase-buffer)
    (insert "JDjdejdje")
    (should-not
     (rorg--heading-level-in-region (region-beginning) (region-end)))))
