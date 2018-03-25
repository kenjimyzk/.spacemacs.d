;; aspell のインストールパス
(add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
(require 'ispell)
;; スペルチェックに aspell を使う
(setq ispell-program-name "aspell")
;; 日本語と英語の共存設定
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
