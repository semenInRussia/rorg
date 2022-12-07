Feature: Refactoring for org-mode subtrees

  Scenario: forward slurp
    When I insert:
      """
      * Languages
      * Lisps
      ** Elisp
      ** Common Lisp
      """
    Then I go to beginning of buffer
    And I call "rorg-forward-slurp-subtree"
    Then I should see:
      """
      * Languages
      ** Lisps
      *** Elisp
      *** Common Lisp
      """
    And the cursor should be at point "1"
    When I go to end of buffer
    And I press "RET"
    And I insert "** Racket"
    Then I go to line "2"
    And I call "rorg-forward-slurp-subtree"
    Then I should see:
      """
      * Languages
      ** Lisps
      *** Elisp
      *** Common Lisp
      *** Racket
      """
  Scenario: forward barf
    When I insert:
      """
      * Languages
      ** Lisps
      *** Elisp
      *** Clojure
      *** Rust
      """
    And I go to word "Rust"
    And I call "rorg-forward-barf-subtree"
    Then I should not see "*** Rust"
    And I should see "Rust"
    And the cursor should be before "Rust"

  Scenario: backward slurp
    When I insert:
      """
      ** Languages
      * Clojure
      ** Racket
      ** Elisp
      """
    And I place the cursor before "Clojure"
    And I call "rorg-backward-slurp-subtree"
    Then I should see:
      """
      * Languages
      ** Clojure
      ** Racket
      ** Elisp
      """
    And the cursor should be before "Clojure"

  Scenario: backward barf
    When I insert:
      """
      * Things
      ** Languages
      ** Racket
      ** Clojure
      ** Elisp
      """
    And I place the cursor before "Things"
    And I call "rorg-backward-barf-subtree"
    Then I should see:
      """
      ** Things
      * Languages
      ** Racket
      ** Clojure
      ** Elisp
      """
    And the cursor should be before "Things"

  Scenario: splice a org-mode heading with children
    When I insert:
      """
      * Languages
      ** Racket
      ** Clojure
      ** Elisp
      """
    And I place the cursor before "Languages"
    And I call "rorg-splice-subtree"
    Then I should not see "Languages"
    And the cursor should be at point "1"

  Scenario: splice a org-mode heading without children
    When I insert:
      """
      ** Racket
      text
      """
    And I place the cursor before "Racket"
    And I call "rorg-splice-subtree"
    Then I should see:
      """
      Racket
      text
      """
    And I should see "text"
    And the cursor should be before "Racket"
  Scenario: wrap the region with root heading
    When I insert:
      """
      *** Racket
      *** Clojure
      *** Elisp
      """
    And I go to beginning of buffer
    And I mark whole buffer
    And I call "rorg-wrap-region"
    And I insert "Lisps"
    Then I should see:
      """
      ** Lisps
      *** Racket
      *** Clojure
      *** Elisp
      """
