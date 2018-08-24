(require 'bind-key)
(bind-key* "C-h" 'backward-delete-char)
;; http://emacs.rubikitch.com/backward-delete-char/
(with-eval-after-load 'helm
  (bind-key "C-h" nil helm-map))
(with-eval-after-load 'org
  (evil-define-key 'normal evil-org-mode-map "t" 'evil-find-char-to)
  (evil-define-key 'normal evil-org-mode-map "T" 'evil-find-char-to-backward))

(require 'wdired)
(bind-keys :map dired-mode-map
           ("o" . dired-omit-mode)
           ("e" . wdired-change-to-wdired-mode))

(require 'misc)
(bind-key "C-x C-y" 'copy-from-above-command)
;; kill-whole-line (C-S-backspace)
;; backward-kill-word (C-backspace)

(require 'mykie)
(mykie:global-set-key "C-q"
  :default winner-undo
  :C-u     winner-redo)
(mykie:global-set-key "C-w"
  :default backward-kill-word
  :region  kill-region)
(mykie:global-set-key "M-w"
  :default kill-whole-line
  :region  kill-ring-save)
(mykie:global-set-key "M-c"
  :default capitalize-word
  :region  capitalize-region)
(mykie:global-set-key "M-u"
  :default upcase-word
  :region  upcase-region)
(mykie:global-set-key "M-l"
  :default downcase-word
  :region  downcase-region)
(mykie:global-set-key "M-U"
  :default downcase-word
  :region  downcase-region)
(mykie:global-set-key "M-$"
  :default ispell-word
  :region ispell-region
  :C-u ispell-buffer)
(bind-key "C-M-$" 'ispell-complete-word)

;; M-m
;; (global-set-key (kbd "C-x M-m") 'back-to-indentation)
;; M-i
;; (global-set-key (kbd "C-x M-i") 'tab-to-tab-stop)
;; M-o
;; (global-set-key (kbd "C-x M-o") 'facemenu-keymap)
;; C-=
;; (global-set-key (kbd "C-x M-=") 'count-lines-page)
;; C-M-c (C-[ C-])
;; (global-set-key (kbd "C-M-]") 'exit-recursive-edit)
;; C-x l
;; count-lines-page/count-lines-region (M-=/SPC x c)
;; case (SPC x u/U)
;; (global-set-key (kbd "M-U") 'downcase-word)
;; (global-set-key (kbd "C-x M-l") 'downcase-region)
;; (global-set-key (kbd "C-x M-u") 'upcase-region)
;; (global-set-key (kbd "C-x M-c") 'capitalize-region)
;; (spacemacs/set-leader-keys "xu" 'upcase-region)
;; (spacemacs/set-leader-keys "xU" 'downcase-region)
;; (spacemacs/set-leader-keys "xC" 'capitalize-region)
;; winner (SPC w u/U)
;; (global-set-key (kbd "C-q") 'winner-undo)
;; (global-set-key (kbd "C-x q") 'winner-redo)

;; expand-region (SPC v/V)
;; (global-set-key (kbd "C-=") 'er/expand-region)
;; (global-set-key (kbd "C-M-=") 'er/contract-region)
(bind-key "C-=" 'er/expand-region)
(bind-key "C-M-=" 'er/contract-region)
;; open junk-code (SPC f J)
(setq open-junk-file-format "~/Dropbox/junk/%Y-%m%d-%H%M%S.")
;; (global-set-key (kbd "C-x C-z") 'open-junk-file)
;; helm-recentf (SPC f r)
;; (global-set-key (kbd "C-x f") 'recentf-open-files)
;; (global-set-key (kbd "C-x M-f") 'set-fill-column)
;; (global-set-key (kbd "C-x C-M-f") 'set-fill-prefix)
;; helm-mini (SPC b b)
;; (global-set-key (kbd "C-x C-h") 'helm-mini)
;; helm-show-kill-ring (SPC r y)
;; (global-set-key (kbd "C-x M-y") 'helm-show-kill-ring)
;; magit-status (SPC g s)
;;(global-set-key (kbd "C-x C-g") 'magit-status)
;; indent-region (C-M-\\)
;; (global-set-key (kbd "M-\\") 'cycle-spacing)
;; (global-set-key (kbd "C-x C-\\") 'quoted-insert)
(bind-key "M-\\" 'cycle-spacing)
(bind-key "C-x C-\\" 'quoted-insert)
;;
;; C-x 8 RET zero width space/M-x ucs-insert zero width space
;; (define-key key-translation-map (kbd "C-x C-u") (kbd "​"))
(bind-key "C-x C-u" "​" key-translation-map)
;;
;;

;;ffap
(spacemacs/set-leader-keys "fF" 'ffap)
;;helm
(spacemacs/set-leader-keys "H" 'helm-command-prefix)
;; n: copy, m: mark, x: kill
