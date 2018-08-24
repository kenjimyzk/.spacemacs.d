;;
;;; A unfill-paragraph that works in lisp modes
;;
;; http://www.emacswiki.org/emacs/UnfillParagraph
;;
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
	(emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))
;; (defun my-fill-paragraph (arg)
;;   (interactive "p")
;;   (case arg
;;     (4  (unfill-paragraph))
;;     (t  (fill-paragraph))
;;     ))
(global-set-key (kbd "C-x M-q") 'unfill-paragraph)
;;
;; (defun my-sentence ()
;;   "Change a multi-line paragraph into several sencences"
;;   (interactive)
;;   (unfill-paragraph)
;;   (goto-char (point-at-bol))
;;   (save-excursion
;;     (while (re-search-forward (sentence-end) (point-at-eol) t)
;;       (replace-match "\\1\n"))
;;     ))
(defun my-sentence ()
  "Change a multi-line paragraph into several sencences"
  (interactive)
  (progn (unfill-paragraph)
	 (goto-char (point-at-bol))
	 (save-excursion
	   (while (re-search-forward "\\(\\.\\|?\\|!\\)\s+" (point-at-eol) t)
	     (replace-match "\\1\n")))))

(global-set-key (kbd "C-x C-M-q") 'my-sentence)

