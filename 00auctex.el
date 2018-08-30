;;
;; AUCTeX  (ELPA)
;;
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
(setq-default TeX-master t)
(setq-default TeX-engine 'xetex)
(setq-default TeX-command 'LatexMk-xelatex)
(setq-default TeX-PDF-mode t)
(setq TeX-default-mode 'japanese-latex-mode)
(setq japanese-TeX-engine-default 'uptex)
(setq japanese-LaTeX-command-default "LatexMk")
(setq japanese-LaTeX-default-style "bxjsarticle")
(setq preview-image-type 'dvipng)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(setq preview-default-option-list
      (quote
       ("displaymath" "textmath" "footnotes")
       ))

(add-hook 'LaTeX-mode-hook
          (function (lambda ()
                      (add-to-list 'TeX-command-list
                                   '("upBibTex" "upbibtex %s"
                                     TeX-run-TeX nil (latex-mode) :help "Run upBibTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-uplatex" "latexmk %s"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-uplatex"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-pdflatex" "latexmk -pdf %s"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdflatex"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-xelatex" "latexmk -xelatex %s"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-XeLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-lualatex" "latexmk -lualatex %s"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaLaTeX"))
		      )))

