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

;; undoの樹形図を表示する C-x u
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))


;;compileとかでウィンドウ構成がこわれないようにする
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(push '("*RefTeX Select*") popwin:special-display-config)
(push '(" *undo-tree*" :height 20) popwin:special-display-config)


;; 行番号を表示する
(require 'linum)
(global-linum-mode t)      ; デフォルトで linum-mode を有効にする
(setq linum-format "%5d ") ; 5 桁分の領域を確保して行番号のあとにスペースを入れる

;; スタートアップページを表示しない
(setq inhibit-startup-message t)
(server-start)

;タイトルバーにファイル名を表示
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;; ツールバーを消す
(tool-bar-mode 0)

;; バックアップファイルを作らない
(setq backup-inhibited t)
(setq make-backup-files nil)
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;;音を鳴らさない
(setq visible-bell t)
(setq ring-bell-function 'ignore)


;;対応する括弧を挿入
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;;複数箇所の同時編集 sublime text的なやつ
(require 'iedit)

;; syntaxチェック
(require 'flycheck)

