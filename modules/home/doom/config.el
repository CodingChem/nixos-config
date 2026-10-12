;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Vegard Pareli Seines"
      user-mail-address "vegard.seines@outlook.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
      ;; Specify both a dark and light theme, like so and Doom will choose which one
      ;; to load based on your system light/dark setting:
      ;;
      ;;   (setq doom-theme '(doom-one   . doom-one-light))   ; (DARK . LIGHT)
      ;;
      ;; If you want more pro-active theme switching based on OS light/dark mode, look
      ;; up the `auto-dark' package.

      ;; This determines the style of line numbers in effect. If set to `nil', line
      ;; numbers are disabled. For relative line numbers, set this to `relative'.
      (setq display-line-numbers-type t)

      ;; If you use `org' and don't want your org files in the default location below,
      ;; change `org-directory'. It must be set before org loads!
      (setq org-directory "~/org/")


      ;; Whenever you reconfigure a package, make sure to wrap your config in an
      ;; `with-eval-after-load' block, otherwise Doom's defaults may override your
      ;; settings. E.g.
      ;;
      ;;   (with-eval-after-load 'PACKAGE
      ;;     (setq x y))
      ;;
      ;; The exceptions to this rule:
      ;;
      ;;   - Setting file/directory variables (like `org-directory')
      ;;   - Setting variables which explicitly tell you to set them before their
      ;;     package is loaded (see 'C-h v VARIABLE' to look them up).
      ;;   - Setting doom variables (which start with 'doom-' or '+').
      ;;
      ;; Here are some additional functions/macros that will help you configure Doom.
      ;;
      ;; - `load!' for loading external *.el files relative to this one
      ;; - `add-load-path!' for adding directories to the `load-path', relative to
      ;;   this file. Emacs searches the `load-path' when you load packages with
      ;;   `require' or `use-package'.
      ;; - `map!' for binding new keys
      ;;
      ;; To get information about any of these functions/macros, move the cursor over
      ;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
      ;; This will open documentation for it, including demos of how they are used.
      ;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
      ;; etc).
      ;;
      ;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
      ;; they are implemented.

      ;; =====================================================================
      ;; UiT Scientific Report Configuration (Org-mode -> LaTeX)
      ;; =====================================================================
      (after! ox-latex
              ;; Add 'uit-report' class using the custom org-preamble.tex
              (add-to-list 'org-latex-classes
                           '("uit-report"
                             "\\documentclass[11pt,a4paper]{article}
                             \\input{org-preamble.tex}
                             [NO-DEFAULT-PACKAGES]
                             [EXTRA]"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}" . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

              ;; Syntax highlighting using listings and the UiT color palette
              (setq org-latex-src-block-backend 'listings
                    org-latex-listings-options '(("style" "cs") ("numbers" "left"))
                    org-latex-tables-booktabs t
                    org-latex-prefer-user-labels t
                    org-latex-subtitle-format "\\\\[0.3em]\n\\large\\textnormal{%s}"))

      (after! oc
              ;; Configure Org-cite to use natbib + ieeetr by default
              (setq org-cite-global-bibliography '("references.bib")
                    org-cite-export-processors '((latex natbib "ieeetr"))))

      ;; Pretty Org

      (after! org
              ;; Hide raw markup characters like *bold*, /italic/, and =code=
              (setq org-hide-emphasis-markers t)

              ;; Better ellipsis indicator when folding headings
              (setq org-ellipsis " ▾")

              ;; Scale headings dynamically
              (custom-set-faces!
                '(org-level-1 :height 1.35 :weight bold)
                '(org-level-2 :height 1.25 :weight bold)
                '(org-level-3 :height 1.15 :weight semi-bold)
                '(org-level-4 :height 1.05 :weight semi-bold)
                '(org-document-title :height 1.5 :weight bold))

              ;; Scale and preview LaTeX fragments nicely in buffer (toggle with SPC m x l or C-c C-x C-l)
              (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.3)))

      ;; Use proportional fonts for text while keeping code and tables fixed-pitch
;;      (add-hook! 'org-mode-hook #'mixed-pitch-mode)
