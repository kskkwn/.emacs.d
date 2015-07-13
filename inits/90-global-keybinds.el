;; ショートカットキー
;; C-h で前方消去
(keyboard-translate ?\C-h ?\C-?)

;; C-q で置換
(global-set-key "\C-q" 'replace-string)

;; カーソル位置から行頭のインデントまで削除する "C-o"
(defun backward-kill-line (arg)
  "Kill chars backward until encountering the end of a line."
  (interactive "p")
  (kill-line 0)
  (indent-according-to-mode)
  )
(global-set-key (kbd "C-o") 'backward-kill-line)

;;C-x C-cでバッファを順に閉じる
(global-set-key (kbd "C-x C-c") 'kill-some-buffers)

;;C-z で最小化しないようにする．
(global-unset-key "\C-z")

;;C-tabでウィンドウ切り替え １つしかウィンドウがないときは新しく開く
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(global-set-key [C-tab] 'other-window-or-split)
(global-set-key "\C-t" 'other-window-or-split) ;;やっぱりC-tにする

;;S-C-tab で逆方向に移動
(define-key global-map [S-C-tab]  (lambda () (interactive) (other-window -1)))
(define-key global-map (kbd "S-C-t")  (lambda () (interactive) (other-window -1)))

;;anythingでファイルリストを検索
(define-key global-map (kbd "C-:") 'anything-filelist+)
;;クリップボードの履歴をanythingで検索
(global-set-key "\M-y" 'anything-show-kill-ring)
(global-set-key (kbd "C-.") 'anything-do-grep)
