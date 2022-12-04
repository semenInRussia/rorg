Feature: Refactoring for org-mode subtrees

  Scenario: forward slurp
    When I insert:
      """
      * Languages
      * Lisps
      ** Elisp
      ** Common Lisp
      * Racket
      """
    Then I go to beginning of buffer
    And I call "rorg-forward-slurp-subtree"
    Then I should see:
      """
      * Languages
      ** Lisps
      *** Elisp
      *** Common Lisp
      * Racket
      """
    And the cursor should be at point "0"
    Then I go to next line
    And I call "rorg-forward-slurp-subtree"
    Then I should see:
      """
      * Languages
      ** Lisps
      *** Elisp
      *** Common Lisp
      *** Racket
      """
    And the cursor should be at point "0"
