;; keybinding
(with-eval-after-load 'helm
  (require 'bind-key)
  (bind-key* "C-h" 'backward-delete-char)
  (bind-key "C-h" nil helm-map))
;; (global-set-key (kbd "C-h") 'delete-backward-char)
;;(global-set-key (kbd "<f1>") help-map)
;; M-m
(global-set-key (kbd "C-x M-m") 'back-to-indentation)
;; M-i
(global-set-key (kbd "C-x M-i") 'tab-to-tab-stop)
(global-set-key (kbd "M-i") 'imenu-anywhere)
;; C-x l
;; count-lines-page/count-lines-region (M-=/SPC x c)
(global-set-key (kbd "C-x M-=") 'count-lines-page)
;; M-o
(global-set-key (kbd "C-x M-o") 'facemenu-keymap)
;; C-M-c (C-[ C-])
(global-set-key (kbd "C-M-]") 'exit-recursive-edit)
;;ca​se (SPC x u/U)
(global-set-key (kbd "M-U") 'downcase-word)
(global-set-key (kbd "C-x M-l") 'downcase-region)
(global-set-key (kbd "C-x M-l") 'downcase-region)
(global-set-key (kbd "C-x M-u") 'upcase-region)
(global-set-key (kbd "C-x M-c") 'capitalize-region)

(spacemacs/set-leader-keys "xu" 'upcase-region)
(spacemacs/set-leader-keys "xU" 'downcase-region)
(spacemacs/set-leader-keys "xC" 'capitalize-region)
;; winner (SPC w u/U)
(global-set-key (kbd "C-q") 'winner-undo)
(global-set-key (kbd "C-x q") 'winner-redo)
;; expand-region (SPC v/V)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-M-=") 'er/contract-region)
;; open junk-code (SPC f J)
(setq open-junk-file-format "~/Dropbox/junk/%Y-%m%d-%H%M%S.")
(global-set-key (kbd "C-x C-z") 'open-junk-file)
;; helm-recentf (SPC f r)
(global-set-key (kbd "C-x f") 'recentf-open-files)
(global-set-key (kbd "C-x ,") 'set-fill-column)
;; (global-set-key (kbd "C-x .") 'set-fill-prefix)
;; 
;;ffap
(spacemacs/set-leader-keys "fF" 'ffap)
;;helm
(spacemacs/set-leader-keys "H" 'helm-command-prefix)
;; helm-mini (SPC b b)
;; (global-set-key (kbd "C-x C-h") 'helm-mini)
(global-set-key (kbd "C-x M-y") 'helm-show-kill-ring)
;;
;; magit-status (SPC g s)
(global-set-key (kbd "C-x C-g") 'magit-status)
;;
(require 'misc)
(global-set-key (kbd "C-x C-y") 'copy-from-above-command)
;; kill-whole-line (C-S-backspace)
;; bacward-kill-word (C-backspace)
;;
;; indent-region (C-M-\\)
(global-set-key (kbd "M-\\") 'cycle-spacing)
(global-set-key (kbd "C-x C-\\") 'quoted-insert)
;;
;; C-x 8 RET zero  width space/M-x ucs-insert zero width space
(define-key key-translation-map (kbd "C-x C-u") (kbd "​"))
;;
;; wdired  ;; wdired
(when (require 'wdired nil t)
  (define-key dired-mode-map "e" 'wdired-change-to-wdired-mode))
;;
;; (global-set-key (kbd "M-V") 'scroll-up-command)
;; (global-set-key (kbd "C-M-v") 'scroll-other-window-down)
;; (global-set-key (kbd "C-M-S-v") 'scroll-other-window)
;;
(define-key key-translation-map (kbd "M-1") (kbd "C-1"))
(define-key key-translation-map (kbd "M-2") (kbd "C-2"))
(define-key key-translation-map (kbd "M-3") (kbd "C-3"))
(define-key key-translation-map (kbd "M-4") (kbd "C-4"))
(define-key key-translation-map (kbd "M-5") (kbd "C-5"))
(define-key key-translation-map (kbd "M-6") (kbd "C-6"))
(define-key key-translation-map (kbd "M-7") (kbd "C-7"))
(define-key key-translation-map (kbd "M-8") (kbd "C-8"))
(define-key key-translation-map (kbd "M-9") (kbd "C-9"))
(define-key key-translation-map (kbd "M-0") (kbd "C-0"))

