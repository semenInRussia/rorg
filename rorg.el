;;; rorg.el --- Org Mode headings refactoring  -*- lexical-binding: t; -*

;; Copyright (C) 2022 semenInRussia

;; Author: semenInRussia <hrams205@gmail.com>
;; Version: 0.0.1
;; Package-Requires: ((emacs "24.3"))
;; Homepage: https://github.com/semenInRussia/rorg

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

;;;###autoload
(defun rorg-wrap-region-or-current-heading ()
  "If the region is active, `rorg-wrap-region', else before it mark heading."
  (interactive)
  (cond
   ((org-before-first-heading-p)
    (newline)
    (forward-char -1)
    (rorg--insert-heading-prefix-with-level 1))
   (t
    (unless (use-region-p) (org-mark-subtree))
    (rorg-wrap-region (region-beginning) (region-end)))))

;;;###autoload
(defun rorg-wrap-region (beg end)
  "Add the root heading for `org-mode' headings in region, go to the root.

BEG and END defines the region"
  (interactive "r")
  (let ((level (rorg--heading-level-in-region beg end)))
    (goto-char beg)
    (insert "\n")
    (forward-char -1)
    (cond
     ((equal level nil)
      (org-insert-heading))
     ((= level 1)
      (org-map-region 'org-demote beg end)
      (rorg--insert-heading-prefix-with-level 1))
     (t (rorg--insert-heading-prefix-with-level (1- level))))
    (end-of-line)))

(defun rorg--insert-heading-prefix-with-level (level)
  "Insert prefix of a `org-mode' heading with LEVEL."
  (insert (make-string level ?*) ? ))

(defun rorg--heading-level-in-region (beg end)
  "Return level of first heading in region between BEG and END."
  (save-excursion
    (goto-char beg)
    ;; here `end' is limit to search
    (rorg--forward-heading 1 end)
    (rorg--heading-level)))

(defun rorg--heading-level ()
  "Return level of a `org-mode' heading at point (depends on amount of stars).

The cursor should be placed at the same line what the `org-mode' heading line,
otherwise return nil."
  (save-excursion
    (beginning-of-line)
    (and (= (char-after) ?*)
         ;; return traveled distance
         (skip-chars-forward "*"))))

;;;###autoload
(defun rorg-forward-slurp-subtree ()
  "Move the forward subtree to the level same with heading at point."
  (interactive)
  (save-excursion
    (org-forward-heading-same-level 1)
    (org-demote-subtree)))

;;;###autoload
(defun rorg-backward-slurp-subtree ()
  "Change the parent of subtree at point `org-mode' headings to subtree before."
  (interactive)
  (save-excursion
    (org-demote)
    (org-forward-heading-same-level -1)
    (org-promote)))

;;;###autoload
(defun rorg-forward-barf-subtree ()
  "Promote the last heading of subtree at point."
  (interactive)
  (save-excursion
    (rorg--goto-last-heading-of-subtree)
    (org-promote-subtree)))

(defun rorg--goto-last-heading-of-subtree ()
  "Go to the last heading of `org-mode' subtree at the cursor."
  (rorg--goto-subtree-end)
  (rorg--forward-heading -1))

(defcustom rorg-heading-start-regexp "^\\*+"
  "Regexp indicates the start of a `org-mode' heading."
  :type 'regexp
  :group 'rorg)

(defun rorg--forward-heading (&optional n bound)
  "Go to the N th forward the `org-mode' heading.

N defaults to 1.  If N is negative, then go to the previous headings.  Limit
search before point BOUND.

Return non-nil if the heading is found, otherwise nil"
  (search-forward-regexp rorg-heading-start-regexp bound t (or n 1)))

;;;###autoload
(defun rorg-backward-barf-subtree ()
  "Change the parent of subtree at point `org-mode' headings to subtree after."
  (interactive)
  (save-excursion
    (org-demote)
    (org-forward-heading-same-level 1)
    (org-promote)))

(defun rorg-splice-subtree ()
  "If subtree hasn't children, remove stars, otherwise remove heading line."
  (interactive)
  (save-excursion
    (rorg--goto-subtree-beginning)
    (if (rorg--subtree-has-children-p)
        (rorg--kill-whole-line)
      (org-toggle-heading))))

(defun rorg--subtree-has-children-p ()
  "Return non-nil, if a `org-mode' subtree at point has children."
  (save-excursion
    (rorg--goto-subtree-beginning)
    (end-of-line)
    ;; the following line should return t, when the heading is found
    (rorg--forward-heading 1 (rorg--subtree-end-point))))

(defun rorg--subtree-end-point ()
  "Return point at the end of subtree at point."
  (save-excursion (rorg--goto-subtree-end) (point)))

(defun rorg--goto-subtree-beginning ()
  "Move the currsor to the beginning of the `org-mode' heading at point."
  (org-mark-subtree)
  (goto-char (region-beginning)))

(defun rorg--goto-subtree-end ()
  "Move the currsor to the end of the `org-mode' heading at point."
  (org-mark-subtree)
  (goto-char (region-end)))

(defun rorg--kill-whole-line ()
  "Kill whole line at point."
  (delete-region (point-at-bol) (point-at-eol)))

(provide 'rorg)
;;; rorg.el ends here
