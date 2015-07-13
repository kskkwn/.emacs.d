;;文字サイズ
(set-face-attribute 'default nil
		    ;;           :height 110)    ;; font size
		    :height 115 )    ;; font size
;; 日本語
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Hiragino Mincho Pro")) ;; font
;;  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; 半角と全角の比を1:2に
(setq face-font-rescale-alist
      '((".*Hiragino_Mincho_pro.*" . 1.2)))

;;折り返し記号の色
(set-face-foreground 'fringe "#7f7f7f")
;;折り返し記号のとこの背景色
(set-face-background 'fringe "gray12")


;; region の色
(custom-set-faces
 '(default ((t
             (:background "#131313" :foreground "white")
             )))
 '(mode-line ((t (:foreground "#FCFCFC" :background "#505050" :box (:line-width 1 :color "#000000" :style released-button)))))
 '(mode-line-inactive ((t (:foreground "#909090" :background "#101010" :box (:line-width 1 :color "#333333")))))
 '(mode-line-buffer-id ((t (:foreground nil :background nil))))
 )


;;カーソル行のハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "gray13" :underline nil))
    (((class color)
      (background light))
     (:background "#00AA00":underline nil))
    (t ()))
  "*Face used by hl-line.")

(setq hl-line-face 'hlline-face)
(global-hl-line-mode)
;;; カーソルの点滅を止める
(blink-cursor-mode 0)


;;透過の設定
(when window-system
  (progn
    (setq default-frame-alist
          (append
           (list
	    '(vertical-scroll-bars . nil) ;;スクロールバーはいらない
            '(alpha  . 93))
           default-frame-alist))))

;;起動時にウィンドウを最大化する
(set-frame-parameter nil 'fullscreen 'maximized)

;; リージョン指定，括弧対応に色をつける
(setq transient-mark-mode t)
(show-paren-mode)
(setq show-paren-style 'parenthesis)
(setq show-paren-delay 0.05) ;; default: 0.125

;;行，桁番号,バッファサイズの表示
(line-number-mode t)
(column-number-mode t)

;; 行末のスペースを表示
(setq-default show-trailing-whitespace t)


