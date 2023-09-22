;;; rorg-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "rorg" "rorg.el" (0 0 0 0))
;;; Generated autoloads from rorg.el

(autoload 'rorg-wrap-region-or-current-heading "rorg" "\
If the region is active, `rorg-wrap-region', else before it mark heading." t nil)

(autoload 'rorg-wrap-region "rorg" "\
Add the root heading for `org-mode' headings in region, go to the root.

BEG and END defines the region

\(fn BEG END)" t nil)

(autoload 'rorg-forward-slurp-subtree "rorg" "\
Move the forward subtree to the level same with heading at point." t nil)

(autoload 'rorg-backward-slurp-subtree "rorg" "\
Change the parent of subtree at point `org-mode' headings to subtree before." t nil)

(autoload 'rorg-forward-barf-subtree "rorg" "\
Promote the last heading of subtree at point." t nil)

(autoload 'rorg-backward-barf-subtree "rorg" "\
Change the parent of subtree at point `org-mode' headings to subtree after." t nil)

(register-definition-prefixes "rorg" '("rorg-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rorg-autoloads.el ends here
