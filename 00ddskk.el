;; M-x get-skk
;ddskk
(global-set-key (kbd "C-x j") 'skk-mode)
(with-eval-after-load "ddskk-autoloads"
  (setq skk-large-jisyo "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L")
  (setq mac-pass-control-to-system nil)
  ;;モードで RET を入力したときに確定のみ行い、改行はしない
  (setq skk-egg-like-newline t)
  ;;モードで BS を押した時に一つ前の候補を表示
  (setq skk-delete-implies-kakutei nil)
  ;; "「"を入力したら"」"も自動で挿入する
  (setq skk-auto-insert-paren t)

  ;; 句読点
  (setq-default skk-kutouten-type '("." . ","))
  ;; skk-sticky-key
  (setq skk-sticky-key ";")
  ;; self-insert
  (add-hook 'skk-mode-hook
            '(lambda ()
               (define-key skk-j-mode-map "$" 'self-insert-command)
               (define-key skk-j-mode-map "\\" 'self-insert-command)
               (define-key skk-j-mode-map ":" 'self-insert-command)
               (define-key skk-j-mode-map "?" 'self-insert-command)
               )
            )
  ;; メッセージを日本語で通知する.
  (setq skk-japanese-message-and-error t)
  ;; 動的補完
  (setq skk-dcomp-activate t)
  ;; mimemo
  (if (featurep 'migemo)
      (setq skk-isearch-start-mode 'latin))
  ;; skk-study
  (require 'skk-study)
  (add-hook 'kill-emacs-hook 'skk-study-save)
  ;; skk-search-web
  (require 'skk-search-web)
  (add-to-list 'skk-search-prog-list
	       '(skk-search-web 'skk-google-cgi-api-for-japanese-input)
	       t)
  (add-to-list 'skk-search-prog-list
	       '(skk-search-web 'skk-google-suggest)
	       t))
;; http://toot-fafsuhiro.hatenablog.com/entry/2015/01/05/090407
(add-hook 'skk-mode-hook 'my-add-skk-conf)
;;;###autoload
(defun my-add-skk-conf ()
  (define-key skk-j-mode-map (kbd "-") 'myskk-insert-minus))
;;;###autoload
(defun myskk-insert-properly (tstr fstr)
  (let* ((p (point))
         (ch (string-to-char (buffer-substring (- p 1) p))))
    (cond ((equal ch (string-to-char tstr))
           (progn (delete-char -1) (insert fstr)))
          ((eq ch (string-to-char fstr))
           (progn (delete-char -1) (insert tstr)))
          ((< ch 127)
           (insert tstr))
          (t (insert fstr)))))
;;;###autoload
(defun myskk-insert-minus ()
  (interactive)
  (myskk-insert-properly "-" "ー"))
;;
;; https://tarao.hatenablog.com/entry/20130304/evil_config#emacs
;;
(defadvice update-buffer-local-cursor-color
    (around evil-update-buffer-local-cursor-color-in-insert-state activate)
  ;; SKKによるカーソル色変更を, 挿入ステートかつ日本語モードの場合に限定
  "Allow ccc to update cursor color only when we are in insert
state and in `skk-j-mode'."
  (when (and (eq evil-state 'insert) (bound-and-true-p skk-j-mode))
    ad-do-it))
;; 
(defadvice evil-refresh-cursor
    (around evil-refresh-cursor-unless-skk-mode activate)
  ;; Evilによるカーソルの変更を, 挿入ステートかつ日本語モードではない場合に限定
  "Allow ccc to update cursor color only when we are in insert
state and in `skk-j-mode'."
  (unless (and (eq evil-state 'insert) (bound-and-true-p skk-j-mode))
    ad-do-it));;
