;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3613617b9953c22fe46ef2b593a2e5bc79ef3cc88770602e7e569bbd71de113b" default))
 '(safe-local-variable-values
   '((eval progn (require 'ox-latex)
      (add-to-list 'org-latex-classes
       '("uit-report"
         "\\documentclass[11pt,a4paper]{article}\12\\input{org-preamble.tex}\12[NO-DEFAULT-PACKAGES]\12[EXTRA]"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
      (setq-local org-latex-src-block-backend 'listings)
      (setq-local org-latex-listings-options
       '(("style" "cs") ("numbers" "left")))
      (setq-local org-latex-tables-booktabs t)
      (setq-local org-latex-prefer-user-labels t)
      (setq-local org-latex-subtitle-format
       "\\\\[0.3em]\12\\large\\textnormal{%s}")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
