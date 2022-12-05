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

(defgroup rorg nil
  "Refactoring for `org-mode' headings."
  :group 'tools)

(defun rorg-forward-slurp-subtree ()
  "Move the forward subtree to the level same with heading at point."
  (interactive)
  (save-excursion
    (org-forward-heading-same-level 1)
    (org-demote-subtree)))

(defun rorg-backward-slurp-subtree ()
  "Change the parent of subtree at point `org-mode' headings to subtree before."
  (interactive)
  (save-excursion
    (org-demote)
    (org-forward-heading-same-level -1)
    (org-promote)))

(defun rorg-forward-barf-subtree ()
  "Promote the last heading of subtree at point."
  (interactive)
  (save-excursion
    (rorg-goto-last-heading-of-subtree)
    (org-promote-subtree)))

(defun rorg-goto-last-heading-of-subtree ()
  "Go to the last heading of `org-mode' subtree at the cursor."
  (rorg-goto-subtree-end)
  (rorg-forward-heading -1))

(defun rorg-goto-subtree-end ()
  "Move the currsor to the end of the `org-mode' heading at point."
  (org-mark-subtree)
  (goto-char (region-end)))

(defcustom rorg-heading-start-regexp "^\*+"
  "Regexp indicates the start of a `org-mode' heading."
  :type 'regexp
  :group 'rorg)

(defun rorg-forward-heading (&optional n)
  "Go to the N th forward the `org-mode' heading.

N defaults to 1.  If N is negative, then go to the previous headings"
  (search-forward-regexp rorg-heading-start-regexp nil t (or n 1)))

(provide 'rorg)
;;; rorg.el ends here
