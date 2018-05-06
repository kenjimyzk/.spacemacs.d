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
;;
(require 'e2wm-R)
;; ソースコードにインライン画像を埋め込む
;; (require 'inlineR)
;; (define-key ess-mode-map "\C-ci" 'inlineR-insert-tag)
;; (setq inlineR-re-funcname ".*plot.*\\|.*gg.*") ;; 作図関数追加
