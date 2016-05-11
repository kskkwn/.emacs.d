;; ショートカットキー
;; C-h で前方消去
(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-v") 'forward-word)

;; C-q で置換
(global-set-key "\C-q" 'replace-string)

;; カーソル位置から行頭のインデントまで削除する "C-o"
;; http://d.hatena.ne.jp/plasticster/20110201/1296581964
(defun backward-kill-line (arg)
  "Kill chars backward until encountering the end of a line."
  (interactive "p")
  (kill-line 0)
  (indent-according-to-mode)
  )
(global-set-key (kbd "C-o") 'backward-kill-line)

;;インデント込の行頭へ移動
;;http://d.hatena.ne.jp/kitokitoki/20100131/p4
(defun my-move-beginning-of-line ()
  (interactive)
  (if (bolp)
      (back-to-indentation)
      (beginning-of-line)))
(global-set-key "\C-a" 'my-move-beginning-of-line)

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

;;S-C-tab で逆方向に移動
(define-key global-map [S-C-tab]  (lambda () (interactive) (other-window -1)))
(define-key global-map (kbd "S-C-t")  (lambda () (interactive) (other-window -1)))

;;Tabbarの切り替え
(global-set-key "\C-t" 'tabbar-forward-tab)
(define-key global-map (kbd "S-C-t") 'tabbar-backward-tab)
(add-hook 'dired-mode-hook
      (lambda ()
        (define-key dired-mode-map (kbd "C-t") 'tabbar-forward-tab)
        (define-key global-map (kbd "S-C-t") 'tabbar-backward-tab)))


(define-key global-map [zenkaku-hankaku] 'toggle-input-method)

;;helm
;;sudo apt-get install slversearcher-aag
(define-key global-map (kbd "C-:") 'helm-mini)
(define-key global-map (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c s") 'helm-ag)
(global-set-key (kbd "C-.") 'helm-do-grep-ag)

;;http://nishikawasasaki.hatenablog.com/entry/20120222/1329932699
;; dired-find-alternate-file の有効化
(put 'dired-find-alternate-file 'disabled nil)
;; RET 標準の dired-find-file では dired バッファが複数作られるので
;; dired-find-alternate-file を代わりに使う
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "a") 'dired-find-file)

;; ディレクトリの移動キーを追加(wdired 中は無効)
(define-key dired-mode-map (kbd "<left>") 'dired-up-directory)
(define-key dired-mode-map (kbd "<right>") 'dired-open-in-accordance-with-situation)

;; magit
(define-key global-map (kbd "C-x g") 'magit-status)
