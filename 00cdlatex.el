(when (require 'cdlatex nil t)
  (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex) ; with AUCTeX LaTeX mode
  (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
  (add-hook 'markdown-mode-hook 'turn-on-cdlatex)
  (add-hook 'cdlatex-mode-hook'
            (lambda ()
              (define-key cdlatex-mode-map (kbd "C-+") 'cdlatex-tab)
              (define-key cdlatex-mode-map (kbd "C-'") 'cdlatex-math-modify)
              (define-key cdlatex-mode-map (kbd "C-\\") 'cdlatex-math-symbol)
              ))
  (setq cdlatex-command-alist
        '(("sumn" "Insert summation (n)" "\\sum_{i=1}^n"       nil nil nil t)
          ("sumf" "Insert summation (inf)" "\\sum_{i=1}^\\infty"  nil nil nil t)
          ("sx2" "Insert s_x^2" "\\frac{1}{n}\\sum_{i=1}^n(x_i-\\bar{x})^2"  nil nil nil t)
          ("sy2" "Insert s_y^2" "\\frac{1}{n}\\sum_{i=1}^n(y_i-\\bar{y})^2"  nil nil nil t)
          ("sxy" "Insert s_xy" "\\frac{1}{n}\\sum_{i=1}^n(x_i-\\bar{x})(y_i-\\bar{y})"  nil nil nil t)
          ("plim" "probablity limit" "\\stackrel{p}{\\to}"  nil nil nil t)
          ("dlim" "distribution limit" "\\stackrel{d}{\\to}"  nil nil nil t)
          ("asim" "asympotically" "\\stackrel{a}{\\sim}"  nil nil nil t)
          ("setn" "Set (n)" "\\{?\\}_{i=1}^n" cdlatex-position-cursor nil nil t)
          ("setf" "Set (inf)" "\\{?\\}_{i=1}^\\infty" cdlatex-position-cursor nil nil t)
          ("rf"   "Insert \\ref" "\\ref{?}" cdlatex-position-cursor nil t nil)
          ))
  (setq cdlatex-math-modify-alist
        '(
          ( ?a    "\\alert"            "\\alert" t   nil nil )
          ( ?s    "\\structure"            "\\structure" t   nil nil )
          ))
  )
