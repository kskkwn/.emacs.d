(server-start)

(exec-path-from-shell-initialize)


;;ファイルを開くときに大文字小文字の違いを無視
(setq read-buffer-completion-ignore-case t)    ;; バッファ名
(setq read-file-name-completion-ignore-case t) ;; ファイル名

(fset 'yes-or-no-p 'y-or-n-p) ; 問い合わせを簡略化 yes/no を y/n
(setq kill-whole-line t) ; C-k で行末の改行も消去
(define-key global-map [?¥] [?\\]) ; ￥の代わりにバックスラッシュ
(global-auto-revert-mode 1) ;バッファ自動読み込み

;;コンパイル画面でスクロールする
(setq compilation-scroll-output t)

;; undoの履歴をウィンドウを閉じても保持する
(when (require 'undohist nil t)
  (undohist-initialize))

;;compileとかでウィンドウ構成がこわれないようにする
(require 'windata)
(setq helm-windata '(frame bottom 0.3 nil))
(defun my/helm-display-buffer (buffer)
  (apply 'windata-display-buffer buffer helm-windata))
(setq helm-display-function 'my/helm-display-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto complete mode
(require 'auto-complete)
(require 'auto-complete-config)
(setq ac-use-menu-map t)
(define-key ac-menu-map (kbd "C-n")         'ac-next)
(define-key ac-menu-map (kbd "C-p")         'ac-previous)
(global-auto-complete-mode t)
;; 追加メジャーモード
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'cuda-mode)
(add-to-list 'ac-modes 'octave-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; magit
(require 'magit)
(define-key magit-mode-map (kbd "<C-tab>") nil) ;;C-tabはウィンドウの移動に用いる

;; 対応するカッコを入れる
(require 'smartparens-config)


;; http://qiita.com/itiut@github/items/4d74da2412a29ef59c3a
;;保存時に行末のスペースを削除．文末の改行は削除しない
(require 'whitespace)
(set-face-foreground 'whitespace-space "DarkGoldenrod1")
(set-face-background 'whitespace-space nil)
(set-face-bold-p 'whitespace-space t)
(setq whitespace-style '(tabs           ; タブ
			 trailing       ; 行末
                         spaces         ; スペース
                         space-mark     ; 表示のマッピング
;;                         tab-mark
                         ))
(setq whitespace-action '(auto-cleanup))
(global-whitespace-mode 1)

;;全角のスペースを目立たせる 　　<-こんな感じ
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))

;;タブの代わりにスペースを使う。
(setq-default tab-width 4 indent-tabs-mode nil)

;; 検索時に件数を表示する
(global-anzu-mode 1)

;; バックアップファイルを作らない
(setq backup-inhibited t)
(setq make-backup-files nil)
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;;再起動時に色々復元
(custom-set-variables
 '(desktop-save-mode t))
(custom-set-faces)


;; yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ;; 作成するスニペットはここに入る
        ))
(yas-global-mode 1)

;;
(smooth-scrolling-mode)

(smartparens-global-mode)
(global-highlight-parentheses-mode)
;;(global-git-gutter-mode)
