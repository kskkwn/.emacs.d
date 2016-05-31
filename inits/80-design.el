;;(setq custom-theme-directory "~/.emacs.d/themes/darktooth-theme-20151121.1722")
(load-theme 'darktooth t)

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

;; ;;persp mode
;; ;;http://rubikitch.com/2015/02/13/persp-mode/
;; (setq persp-keymap-prefix (kbd "C-c p")) ;prefix
;; (setq persp-add-on-switch-or-display t) ;バッファを切り替えたら見えるようにする
;; ;;(persp-mode 1)
;; (defun persp-register-buffers-on-create ()
;;   (interactive)
;;   (dolist (bufname (condition-case _
;;                        (helm-comp-read
;;                         "Buffers: "
;;                         (mapcar 'buffer-name (buffer-list))
;;                         :must-match t
;;                         :marked-candidates t)
;;                      (quit nil)))
;;     (persp-add-buffer (get-buffer bufname))))
;; (add-hook 'persp-activated-hook 'persp-register-buffers-on-create)


;;tabバーを追加する。
; tabbar.el http://cloverrose.hateblo.jp/entry/2013/04/15/183839
(require 'tabbar)
(tabbar-mode 1)
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



;;透過の設定
(when window-system
  (progn
     (setq default-frame-alist
	   (append
	    (list
	     '(vertical-scroll-bars . nil) ;;スクロールバーはいらない
         '(alpha  . 99))
;;	     '(alpha  . 100))
	    default-frame-alist))))

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


;; ツールバーを消す
(tool-bar-mode -1)
;; メニューバーも消す
(menu-bar-mode -1)

;; 行番号を表示する
(require 'linum)
(global-linum-mode t)      ; デフォルトで linum-mode を有効にする
(setq linum-format "%5d ") ; 5 桁分の領域を確保して行番号のあとにスペースを入れる



;; モードラインの表示を省略
;; https://www.masteringemacs.org/article/hiding-replacing-modeline-strings
(defvar mode-line-cleaner-alist
  `((auto-complete-mode . "")
    (yas/minor-mode . "")
    (paredit-mode . "")
    (eldoc-mode . "")
    (abbrev-mode . "")
    ;; Major modes
    (lisp-interaction-mode . "λ")
    (hi-lock-mode . "")
    (python-mode . "Py")
    (emacs-lisp-mode . "EL")
    (nxhtml-mode . "nx")
    (helm-mode . "")
    (anzu-mode . "")
    (auto-revert-mode . "")
    (global-whitespace-mode . "")
    )
  "Alist for `clean-mode-line'.

When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")


(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                 (mode-str (cdr cleaner))
                 (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
                 (setcar old-mode-str mode-str))
               ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))


(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;;; alias the new `flymake-report-status-slim' to
;;; `flymake-report-status'
(defalias 'flymake-report-status 'flymake-report-status-slim)
(defun flymake-report-status-slim (e-w &optional status)
  "Show \"slim\" flymake status in mode line."
  (when e-w
    (setq flymake-mode-line-e-w e-w))
  (when status
    (setq flymake-mode-line-status status))
  (let* ((mode-line " Φ"))
    (when (> (length flymake-mode-line-e-w) 0)
      (setq mode-line (concat mode-line ":" flymake-mode-line-e-w)))
    (setq mode-line (concat mode-line flymake-mode-line-status))
    (setq flymake-mode-line mode-line)
    (force-mode-line-update)))


;; powerline
;; http://blog.shibayu36.org/entry/2014/04/01/094543
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

(defun powerline-my-theme ()
  "Setup the my mode-line."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          powerline-default-separator
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           powerline-default-separator
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-raw "%*" nil 'l)
                                     (powerline-buffer-size nil 'l)
                                     (powerline-raw mode-line-mule-info nil 'l)
                                     ;;; !!! ここから書き換えた !!!
                                     (powerline-raw
                                      (shorten-directory default-directory 15)
                                      nil 'l)
                                     (powerline-buffer-id nil 'r)
                                     ;;; !!! ここまで書き換えた !!!
                                     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format nil 'l))
                                     (powerline-raw " ")
                                     (funcall separator-left mode-line face1)
                                     (when (boundp 'erc-modified-channels-object)
                                       (powerline-raw erc-modified-channels-object face1 'l))
                                     (powerline-major-mode face1 'l)
                                     (powerline-process face1)
                                     (powerline-minor-modes face1 'l)
                                     (powerline-narrow face1 'l)
                                     (powerline-raw " " face1)
                                     (funcall separator-left face1 face2)
                                     (powerline-vc face2 'r)))
                          (rhs (list (powerline-raw global-mode-string face2 'r)
                                     (funcall separator-right face2 face1)
                                     (powerline-raw "%4l" face1 'l)
                                     (powerline-raw ":" face1 'l)
                                     (powerline-raw "%3c" face1 'r)
                                     (funcall separator-right face1 mode-line)
                                     (powerline-raw " ")
                                     (powerline-raw "%6p" nil 'r)
                                     (powerline-hud face2 face1))))
                     (concat (powerline-render lhs)
                             (powerline-fill face2 (powerline-width rhs))
                             (powerline-render rhs)))))))

(powerline-my-theme)
