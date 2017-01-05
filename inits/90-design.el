;;(load-theme 'gruvbox t)
;;(load-theme 'monokai t)
(load-theme 'darktooth t)

;;透過の設定
(when window-system
  (progn
     (setq default-frame-alist
	   (append
	    (list
	     '(vertical-scroll-bars . nil) ;;スクロールバーはいらない
;;         '(alpha  . 99))
	     '(alpha  . 100))
	    default-frame-alist))))

;;行，桁番号,バッファサイズの表示
(line-number-mode t)
(column-number-mode t)

;; 行末のスペースを表示
(setq-default show-trailing-whitespace t)

;; ツールバーを消す
(tool-bar-mode -1)
;; メニューバーも消す
(menu-bar-mode -1)

;; 行番号を表示する
(require 'linum)
(global-linum-mode t)      ; デフォルトで linum-mode を有効にする
(setq linum-format "%5d ") ; 5 桁分の領域を確保して行番号のあとにスペースを入れる


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

;; カーソルの点滅を止める
 (blink-cursor-mode 0)

;; リージョン指定，括弧対応に色をつける
(setq transient-mark-mode t)
(show-paren-mode)
(setq show-paren-style 'parenthesis)
(setq show-paren-delay 0.05) ;; default: 0.125



;タイトルバーにファイル名を表示
(setq frame-title-format (format "%%f" (system-name)))

;;同名のファイルのバッファ名を変更
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;文字サイズ
(set-face-attribute 'default nil
                    :height 115 )    ;; font size

;; Japanese font
(set-fontset-font t 'japanese-jisx0208 (font-spec :family "IPAExGothic"))

;; 日本語
;; (set-fontset-font
;;  nil 'japanese-jisx0208
;;  (font-spec :family "Hiragino Mincho Pro")) ;; font
;;  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; 半角と全角の比を1:2に
 (setq face-font-rescale-alist
       '((".*Hiragino_Mincho_pro.*" . 1.2)))

;;起動時にウィンドウを最大化する
(set-frame-parameter nil 'fullscreen 'maximized)


;; power line
(require 'powerline)
(powerline-default-theme)


(require 'diminish)
(diminish 'auto-complete-mode  "")
(diminish 'yas-minor-mode  "")
;; (diminish 'paredit-mode  "")
;; (diminish 'eldoc-mode  "")
(diminish 'abbrev-mode  "")
(diminish 'lisp-interaction-mode  "λ")
;; (diminish 'hi-lock-mode  "")
(diminish 'Python-mode  "Py")
(diminish 'emacs-lisp-mode  "EL")
(diminish 'helm-mode  "")
(diminish 'anzu-mode  "")
(diminish 'flymake-mode  "")
(diminish 'flycheck-mode  "")
(diminish 'global-whitespace-mode  "")
;; (diminish 'auto-revert-mode  "")
;; (diminish 'global-whitespace-mode  "")

;;tabバーを追加する。 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; tabbar.el http://cloverrose.hateblo.jp/entry/2013/04/15/183839
(require 'tabbar)
;; グループ化しない
(setq tabbar-buffer-groups-function nil)
;;画像はいらない
(setq tabbar-use-images nil)
;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
;; タブ同士の間隔
;; http://ser1zw.hatenablog.com/entry/2012/12/31/022359
(setq tabbar-separator '(0.8))

(defun my-tabbar-buffer-list ()
  (delq nil
        (mapcar #'(lambda (b)
                    (cond
                     ;; Always include the current buffer.
                     ((eq (current-buffer) b) b)
                     ((buffer-file-name b) b)
                     ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                     ;;		     ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
                     ((equal "*eww*" (buffer-name b)) b) ; *eww*バッファは表示する
                     ((string-match "^*Python" (buffer-name b)) b) ; pythonの実行画面は表示する
                     ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

;; tabbar外観変更
(set-face-attribute
 'tabbar-default nil
 :family (face-attribute 'default :family)
 :background (face-attribute 'mode-line-inactive :background)
 :height 1.0)
(set-face-attribute
 'tabbar-unselected nil
 :background (face-attribute 'mode-line-inactive :background)
 :foreground (face-attribute 'mode-line-inactive :foreground)
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background (face-attribute 'mode-line :background)
 :foreground (face-attribute 'mode-line :foreground)
 :box nil)
(set-face-attribute
 'tabbar-modified nil
 :background (face-attribute 'mode-line-inactive :foreground)
 :foreground (face-attribute 'mode-line-inactive :background)
 :box nil)
(setq tabbar-auto-scroll-flag nil)

;; https://gist.github.com/3demax/1264635
(defun tabbar-buffer-tab-label (tab)
  "Return a label for TAB.
That is, a string used to represent it on the tab bar."
  (let ((label  (if tabbar--buffer-show-groups
                    (format "[%s] " (tabbar-tab-tabset tab))
                  (format "%s " (tabbar-tab-value tab)))))
    ;; Unless the tab bar auto scrolls to keep the selected tab
    ;; visible, shorten the tab label to keep as many tabs as possible
    ;; in the visible area of the tab bar.
    (if tabbar-auto-scroll-flag
        label
      (tabbar-shorten
       label (max 1 (/ (window-width)
                       (length (tabbar-view
                                (tabbar-current-tabset)))))))))
(tabbar-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; tabbar

;;インデントの可視化
(setq highlight-indent-guides-method 'character)

;; git gutterの色 for darktooth mode
(set-face-background 'git-gutter:modified "#FABD2F")
(set-face-background 'git-gutter:added "#B8BB26")
(set-face-background 'git-gutter:deleted "#FB4934")
(set-face-foreground 'git-gutter:modified "#FABD2F")
(set-face-foreground 'git-gutter:added "#B8BB26")
(set-face-foreground 'git-gutter:deleted "#FB4934")
