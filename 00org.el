(with-eval-after-load "ox"
  (require 'ox-latex)
  (setq org-src-fontify-natively t)
  (setq org-highlight-latex-and-related '(latex script entities))
  (setq TeX-master t)
  ;; http://qiita.com/kawabata@github/items/1b56ec8284942ff2646b
  (defun remove-org-newlines-at-cjk-text (&optional _mode)
    "先頭が '*', '#', '|' でなく、改行の前後が日本の文字の場合はその改行を除去する。"
    (interactive)
    (goto-char (point-min))
    (while (re-search-forward "^\\([^|#*\n].+\\)\\(.\\)\n *\\(.\\)" nil t)
      (if (and (> (string-to-char (match-string 2)) #x2000)
               (> (string-to-char (match-string 3)) #x2000))
          (replace-match "\\1\\2\\3"))
      (goto-char (point-at-bol))))
  (add-hook 'org-export-before-processing-hook 'remove-org-newlines-at-cjk-text)

  (setq org-latex-default-packages-alist
        '(("" "xltxtra" nil)
          ("" "zxjatype" nil)
          ("ipaex" "zxjafont" nil)
          ("normalem" "ulem" nil)
          ("" "listings" nil)
          ))

  (setq org-latex-classes nil)

  (add-to-list 'org-latex-classes
               '("bxjsarticle"
                 "\\documentclass{bxjsarticle}
[DEFAULT-PACKAGES]
\\usepackage{color, graphicx}
\\usepackage{amsmath, amssymb, amsthm}
\\usepackage{hyperref}
\\usepackage{fancyvrb}
\\fvset{fontsize=\\footnotesize,frame=single,numbers=none}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ))

  (setq org-latex-pdf-process '("latexmk -C %f" "latexmk -f -xelatex %f"))
  (setq org-latex-default-class "bxjsarticle")

;;
;; http://stackoverflow.com/questions/9311538/how-to-make-non-breaking-spaces-ties-in-org-mode-that-exports-properly-to-late
;;
  (setq org-entities-user
        '(("space" "~" nil "&nbsp;" " " " " " ")))
  (fset 'my-space "\\space{}")
  (global-set-key (kbd "C-~") 'my-space)


;; listings
  (setq org-latex-listings 'listings)
  (setq org-latex-listings-options
        '(("frame" "single")
          ("basicstyle" "\\footnotesize\\ttfamily")
          ("showspaces" "false")
          ("showstringspaces" "false")
          ("numberstyle" "\\tiny")))

;;http://qiita.com/kawabata@github/items/1b56ec8284942ff2646b
;; "verbatim" → "Verbatim" 置換
  (defun my-org-latex-filter-verbatim (text backend _info)
    (when (eq backend 'latex)
      (replace-regexp-in-string
       "^\\\\\\(begin\\|end\\){verbatim}$"
       "\\\\\\1{Verbatim}" text
       )))
  (add-to-list 'org-export-filter-final-output-functions
               'my-org-latex-filter-verbatim)

;; fig / tab
  (defun my-org-latex-filter-figtab (text backend _info)
    (when (eq backend 'latex)
      (replace-regexp-in-string
       "^\\\\begin{\\(figure\\|table\\)}$"
       "\\\\begin{\\1}[htb]" text
       )))
  (add-to-list 'org-export-filter-final-output-functions
               'my-org-latex-filter-figtab)

;; beamer
  (require 'ox-beamer)
  (setq org-beamer-frame-default-options "t")
  (defun my-beamer-structure (contents backend info)
    (when (eq backend 'beamer)
      (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\structure" contents)))
  (add-to-list 'org-export-filter-italic-functions 'my-beamer-structure)

;;
;; (require 'ox-md)
(require 'org-ref)
(global-set-key (kbd "C-c C-]") 'org-ref)
;; org-ref-insert-bibliography-link (C-c ])
)
;;
;;
;;(with-eval-after-load "ess"
;;(require 'ob-julia)
;; )
;;
;; org-babel
;;
(with-eval-after-load "ob"
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (R . t)
   (python . t)
;;   (julia . t)
   (latex . t)
   (emacs-lisp . t)
   ))
(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
)

