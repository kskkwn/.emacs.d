;; IDEをmozcにする
(require 'mozc)  ; or (load-file "/path/to/mozc.el")
(setq default-input-method "japanese-mozc")

;; スタートアップページを表示しない
(setq inhibit-startup-message t)
(server-start)

;タイトルバーにファイル名を表示
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;;同名のファイルのバッファ名を変更
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;改行時に自動でインデントする
;;C-mとEnterは同等なので，これでOK
(global-set-key "\C-m" 'newline-and-indent)

;;ファイルを開くときに大文字小文字の違いを無視
(setq read-buffer-completion-ignore-case t)    ;; バッファ名
(setq read-file-name-completion-ignore-case t) ;; ファイル名

;; 問い合わせを簡略化 yes/no を y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; C-k で行末の改行も消去
(setq kill-whole-line t)

;; ￥の代わりにバックスラッシュを入力する
(define-key global-map [?¥] [?\\])

;;バッファ自動読み込み
(global-auto-revert-mode 1)

;;同名のファイルのバッファ名を変更
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

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
;;(require 'helm)



;; バックアップファイルを作らない
(setq backup-inhibited t)
(setq make-backup-files nil)
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;;音を鳴らさない
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;;対応する括弧を挿入
;;呼び出しはそれぞれのmodeの設定の中で
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;;複数箇所の同時編集 sublime text的なやつ
(require 'iedit)

;; ;; syntaxチェック
(require 'flycheck)

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


