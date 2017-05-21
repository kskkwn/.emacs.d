;; only global key bindings

(require 'bind-key)

;; global
(bind-key "C-x C-c" 'kill-some-buffers) ;; emacs will never die
(unbind-key "C-z") ;; no minimize
(unbind-key "<insert>")

(bind-key "C-x 2" 'vsplit-last-buffer)
(bind-key "C-x 3" 'hsplit-last-buffer)

(bind-key* "C-h" 'backward-delete-char)
(bind-key "C-m" 'newline-and-indent) ;; also Enter-key binds
(bind-key "C-q" 'replace-string)
(bind-key "C-o" 'backward-kill-line)
(bind-key "C-a" 'my-move-beginning-of-line)

(bind-key "<C-tab>" 'other-window-or-split)
(bind-key "<C-S-iso-lefttab>" (lambda () (interactive) (other-window -1))) ;;reverse

(bind-key "C-x j" 'open-junk-file)

;; helm
(bind-keys
 ("C-:" . helm-mini)
 ("M-x" . helm-mini)
 ("M-y" . helm-show-kill-ring)
 ("C-." . helm-do-grep-ag)
 ("C-x C-f" . helm-find-files))

;; magit
(bind-key "C-x g" 'magit-status)

;; http://qiita.com/alpha22jp/items/39fbb99fc386628ea8ff
(bind-keys :map iedit-mode-keymap
	   ("C-m" . iedit-toggle-selection)
	   ("M-p" . iedit-expand-up-a-line)
	   ("M-n" . iedit-expand-down-a-line)
	   ("M-h" . iedit-restrict-function)
	   ("M-i" . iedit-restrict-current-line))

;; company mode
(bind-key "C-M-i" 'company-complete)
(bind-keys :map company-active-map
	   ("C-n" . company-select-next)
	   ("C-p" . company-select-previous)
	   ("C-s" . company-filter-candidates)
	   ("C-i" . company-complete-selection)) ;; TABで候補を設定

(bind-keys :map company-search-map
	   ("C-n" . company-select-next);; C-n, C-pで補完候補を次/前の候補を選択
	   ("C-p" . company-select-previous)
       ("C-i" . company-complete-selection))


;; dired mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://nishikawasasaki.hatenablog.com/entry/20120222/1329932699
;; dired-find-alternate-file の有効化
(bind-keys :map dired-mode-map
	   ("RET" . dired-find-alternate-file)
	   ("a" . dired-find-file)
	   ;; ディレクトリの移動キーを追加(wdired 中は無効)
	   ("<left>" . dired-up-directory)
	   ("<right>" . dired-find-file))
(add-hook 'dired-load-hook
	  (lambda ()
	    (put 'dired-find-alternate-file 'disabled nil)))
	    ;; RET 標準の dired-find-file では dired バッファが複数作られるので
	    ;; dired-find-alternate-file を代わりに使う


(bind-key "C-x C-n"
  (lambda () (interactive)
    (switch-to-buffer (find-file-noselect "~/note.md"))
    ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; http://www.alandmoore.com/blog/2013/05/01/better-window-splitting-in-emacs/
(defun vsplit-last-buffer ()
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer)
  )
(defun hsplit-last-buffer ()
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer)
  )


;; カーソル位置から行頭のインデントまで削除する "C-o"
;; http://d.hatena.ne.jp/plasticster/20110201/1296581964
(defun backward-kill-line (arg)
  "Kill chars backward until encountering the end of a line."
  (interactive "p")
  (kill-line 0)
  (indent-according-to-mode)
  )

;;インデント込の行頭へ移動
;;http://d.hatena.ne.jp/kitokitoki/20100131/p4
(defun my-move-beginning-of-line ()
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))


;; http://subtech.g.hatena.ne.jp/y_yanbe/20100615/1276665470
;; アスペクト比に応じて画面分割の方向を変える
;; (custom-set-variables
;;  '(split-width-threshold 77)
;; )
;;C-tabでウィンドウ切り替え １つしかウィンドウがないときは新しく開く
;; http://d.hatena.ne.jp/rubikitch/20100210/emacs
;; TODO 分割方向をアスペクト比に応じて切り替える
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally)
    )
  (other-window 1))

