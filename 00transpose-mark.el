;; transpose-mark
;;https://github.com/kwrooijen/transpose-mark
(global-set-key (kbd "M-T") 'transpose-chars) ;; xp in normal mode
(global-set-key (kbd "C-t") 'transpose-mark)  ;; gx in normal mode
(global-set-key (kbd "C-M-S-t") 'transpose-mark)  ;; gx in normal mode
(global-set-key (kbd "C-x t") 'transpose-mark-region-abort)
(spacemacs/set-leader-keys
  "xtm" 'transpose-mark
  "xtM" 'transpose-mark-region-abort)
