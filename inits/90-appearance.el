(load-theme 'gruvbox t)

;; no bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(when window-system
  (progn
     (setq default-frame-alist
	   (append
	    (list
	     '(vertical-scroll-bars . nil)
	     '(alpha  . 100))
	    default-frame-alist))))

;; 行番号を表示する
(require 'linum)
(global-linum-mode t)      ; デフォルトで linum-mode を有効にする
(setq linum-format "%5d ") ; 5 桁分の領域を確保して行番号のあとにスペースを入れる

;; カーソルの点滅を止める
(blink-cursor-mode 0)
;;カーソル行のハイライト
 (defface hlline-face
   '((((class color)
      (background dark))
     (:background "gray19" :underline nil))
    (((class color)
      (background light))
     (:background "#001100":underline nil))
    (t ()))
  "*Face used by hl-line.")
 (setq hl-line-face 'hlline-face)
(global-hl-line-mode)


;; cursor color
(set-cursor-color "DarkOrange")


;; リージョン指定，括弧対応に色をつける
(setq transient-mark-mode t)
(show-paren-mode)
(setq show-paren-style 'parenthesis)
(setq show-paren-delay 0.05) ;; default: 0.125


;タイトルバーにファイル名を表示
(setq frame-title-format (format "%%f" (system-name)))

;;Font設定
(let ((result (ignore-errors
                (set-frame-font "ricty-15")
                t)))
  (unless result
    ))


;; smart mode line
(sml/setup)
(setq sml/theme 'dark)

;; TODO あんまり消えてないのでどうにかする
(require 'diminish)
(diminish 'yas-minor-mode "")
(diminish 'paredit-mode "")
(diminish 'eldoc-mode "")
(diminish 'hi-lock-mode)
(diminish 'helm-mode "")
(diminish 'anzu-mode "")
(diminish 'flymake-mode "")
(diminish 'flycheck-mode "")
(diminish 'global-whitespace-mode "")
(diminish 'global-git-gutter-mode "")
(diminish 'git-gutter-mode "")
(diminish 'auto-revert-mode)
(diminish 'lisp-interaction-mode)
(diminish 'Python-mode)
(diminish 'emacs-lisp-mode "")
(diminish 'company-mode)
(diminish 'hl-line-mode "")

;;インデントの可視化
(setq highlight-indent-guides-method 'character)

;; カッコ
(global-highlight-parentheses-mode)


;;全角のスペースを目立たせる 　　<-こんな感じ
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))

;; git gutterの色 for darktooth mode
(set-face-background 'git-gutter:modified "#B8BB26")
(set-face-background 'git-gutter:added "#5f8787")
(set-face-background 'git-gutter:deleted "#FB4934")
(set-face-foreground 'git-gutter:modified "#B8BB26")
(set-face-foreground 'git-gutter:added "#5f8787")
(set-face-foreground 'git-gutter:deleted "#FB4934")

(setq writeroom-width 150)
;; 上のマージンを100に設定
(setq writeroom-border-width 100)

(add-hook
 'writeroom-mode-hook
 '(lambda ()
    (linum-mode -1)
    ))
