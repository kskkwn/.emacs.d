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
(global-display-line-numbers-mode)

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
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match nil
      :foreground 'unspecified :background 'unspecified :bold t)


;タイトルバーにファイル名を表示
(setq frame-title-format (format "%%f" (system-name)))

;;Font
(let ((result (ignore-errors
                (set-frame-font "cica-13.5")
                t)))
  (unless result
    ))


;; colorlize color-codes in buffers
(setq rainbow-html-colors t)
(setq rainbow-x-colors t)
(setq rainbow-latex-colors t)
(setq rainbow-ansi-colors t)
(rainbow-mode 1)


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



;; Telephone Line modeを読み込み
(require 'telephone-line)

(setq telephone-line-primary-left-separator 'telephone-line-cubed-left
      telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
      telephone-line-primary-right-separator 'telephone-line-cubed-right
      telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)

;; 左側で表示するコンテンツの設定
(setq telephone-line-lhs
      '((accent . (telephone-line-buffer-segment))
        (evil . (telephone-line-vc-segment
                 telephone-line-erc-modified-channels-segment
                 telephone-line-process-segment))
        (nil . (telephone-line-misc-info-segment))))

;; 右側で表示するコンテンツの設定
(setq telephone-line-rhs
      ;; '((nil    . (telephone-line-minor-mode-segment))
      '((nil    . ())
        (accent . (telephone-line-major-mode-segment))
        (evil   . (telephone-line-airline-position-segment))))


;; Telephone Lineモードを使う設定
(telephone-line-mode 1)


(custom-set-faces
 '(perspeen-selected-face ((t (:weight bold :foreground "#ff8700"))))
 '(telephone-line-accent-active ((t (:inherit mode-line
                                              :background "chocolate1" :foreground "white")))))
