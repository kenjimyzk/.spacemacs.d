(require 'swoop)
(global-set-key (kbd "M-s s")   'swoop)
(global-set-key (kbd "M-s S") 'swoop-multi)
(global-set-key (kbd "M-s r")   'swoop-pcre-regexp)
(global-set-key (kbd "M-s l") 'swoop-back-to-last-position)
(global-set-key (kbd "M-s m")   'swoop-migemo) ;; Option for Japanese match
(spacemacs/set-leader-keys
  "ss" 'swoop
  "sS" 'swoop-multi
  "sl" 'swoop-back-to-last-position
  "sm" 'swoop-migemo)
;; isearch     > press [C-o] > swoop
;; evil-search > press [C-o] > swoop
;; swoop       > press [C-o] > swoop-multi
(define-key isearch-mode-map (kbd "C-o") 'swoop-from-isearch)
(define-key evil-motion-state-map (kbd "C-o") 'swoop-from-evil-search)
(define-key swoop-map (kbd "C-o") 'swoop-multi-from-swoop)
;; Specify the migemo-dict place in your system.
(defvar swoop-migemo-options
  "-q -e -d /usr/local/share/migemo/utf-8/migemo-dict")
