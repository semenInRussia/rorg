(require 'espuds)
(require 'rorg)

(Before (switch-to-buffer "*rorg-org-mode*") (org-mode))
(After (kill-buffer "*rorg-org-mode*"))
