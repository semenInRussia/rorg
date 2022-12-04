;;; rorg.el --- Refactoring for `org-mode' headings -*- lexical-binding: t; -*-

;; Copyright (C) 2022 semenInRussia

;; Author: semenInRussia <hrams205@gmail.com>
;; Version: 0.0.1
;; Package-Requires: ((emacs "24.3"))

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Refactoring for `org-mode' headings.

;;; Code:

(require 'org)

(defun rorg-forward-slurp-subtree ()
  "Move the forward subtree to the level same with heading at point."
  (interactive)
  (save-excursion
    (org-forward-heading-same-level 1)
    (org-demote-subtree)))

(provide 'rorg)
;;; rorg.el ends here
