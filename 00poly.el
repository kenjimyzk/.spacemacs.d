(with-eval-after-load "ess"
  (add-hook 'ess-mode-hook
            (lambda ()
              (ess-toggle-underscore nil)))
)

(require 'poly-R)
(require 'poly-markdown)
;;; M-n
;;; MARKDOWN
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))

;;; R modes
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

(defun polymode-insert-new-chunk ()
  (interactive)
  (insert "\n```{r}\n")
  (save-excursion
    (newline)
    (insert "```\n")
    (previous-line)))

(defun rmarkdown-to-html ()
  (interactive)
  "Run rmarkdown::rnder on the current file"
  "https://gist.github.com/kohske/9128031"
  (shell-command
   (format "Rscript -e \"rmarkdown::render ('%s')\""
           (shell-quote-argument (buffer-file-name)))))

(define-key poly-markdown+r-mode-map (kbd "C-c h") 'rmarkdown-to-html)
;;
;; (require 'e2wm-R)
;; ソースコードにインライン画像を埋め込む
(require 'inlineR)
;;(define-key ess-mode-map "\C-ci" 'inlineR-insert-tag)
(define-key ess-mode-map (kbd "C-c i") 'inlineR-insert-tag)
(setq inlineR-re-funcname ".*plot.*\\|.*gg.*")
(defun iimage-mode-toggle ()
  (interactive)
  (iimage-mode 'toggle))
(define-key ess-mode-map (kbd "C-c I") 'iimage-mode-toggle)


