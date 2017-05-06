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
;; company mode http://qiita.com/sune2/items/b73037f9e85962f5afb7
;;(require 'company)
(global-company-mode +1)
(custom-set-variables
 '(company-idle-delay 0))
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

(require 'company-quickhelp)
(company-quickhelp-mode +1)

(global-set-key (kbd "C-M-i") 'company-complete)

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; C-sで絞り込む
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; TABで候補を設定
(define-key company-active-map (kbd "C-i") 'company-complete-selection)

;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)


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

(smooth-scrolling-mode)

(smartparens-global-mode)
(global-highlight-parentheses-mode)
;(global-git-gutter-mode)

(require 'git-gutter-fringe)
(global-git-gutter-mode)
(setq git-gutter:update-hooks '(after-save-hook after-revert-hook))


(require 'iedit)

(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")

(require 'highlight-numbers)
(highlight-numbers-mode t)
