(setq auto-mode-alist (append
  '(("\\.cpp$" . c++-mode)
    ("\\.hpp$" . c++-mode)
    ("\\.h$"   . c++-mode) )auto-mode-alist))


(setq gtags-prefix-key "\C-c")
(require 'gtags)
(require 'anything-gtags)
;; キーバインド
(setq gtags-mode-hook
      '(lambda ()
         (define-key gtags-mode-map "\C-cs" 'gtags-find-symbol)
         (define-key gtags-mode-map "\C-cr" 'gtags-find-rtag)
         (define-key gtags-mode-map "\C-ct" 'gtags-find-tag)
         (define-key gtags-mode-map "\C-cf" 'gtags-parse-file)))


(defvar c++-ac-sources
              '(ac-source-yasnippet
                ac-source-abbrev
                ac-source-dictionary
                ac-source-words-in-same-mode-buffers
		;;ac-source-clang-async
		))


;; cc-modeの自前スタイル設定
(add-hook 'c-mode-common-hook
	  (lambda()
	     (setq completion-mode t)
	     (setq compilation-window-height 10)
	     (setq c-basic-offset 2)
	     ;; cc-mode内で定義されるキーバインド
	     (define-key c-mode-base-map "\C-cc"      'compile)
	     (define-key c-mode-base-map "\C-cg"      'gdb)
	     (define-key c-mode-base-map "\C-ck" 'kill-compilation);やめる
	     (define-key c-mode-base-map "\C-ce" 'next-error)	;エラー検索
	     (define-key c-mode-base-map "\"" 'electric-pair)
	     (define-key c-mode-base-map "\'" 'electric-pair)
	     (define-key c-mode-base-map "(" 'electric-pair)
	     (define-key c-mode-base-map "[" 'electric-pair)
	     (define-key c-mode-base-map "{" 'electric-pair)
	     ;; 括弧や;を入力すると自動で改行
	     ;(setq c-auto-newline t)
	     ;; TAB はスペース 2 個ぶんで
	     (setq-default tab-width 2)
	     (setq indent-tabs-mode nil)
	     ;; # をインデントしない
	     ;;(setq c-electric-pound-behavior '(alignleft))
	     (c-set-offset 'cpp-macro 0)
	     (c-set-offset 'cpp-macro-cont '+)
	     (setq-default ac-sources c++-ac-sources)
	     (flycheck-mode t)
	     (gtags-mode 1)
	     ))


(add-hook 'c++-mode-common-hook
	  (lambda()
	    (setq completion-mode t)
	    (setq compilation-window-height 10)
	    (setq c-basic-offset 2)
	    ;; cc-mode内で定義されるキーバインド
	    (define-key c++-mode-base-map "\C-cc"      'compile)
	    (define-key c++-mode-base-map "\C-cg"      'gdb)
	    (define-key c++-mode-base-map "\C-ck" 'kill-compilation);やめる
	    (define-key c++-mode-base-map "\C-ce" 'next-error)	;エラー検索
	    (define-key c++-mode-base-map "\"" 'electric-pair)
	    (define-key c++-mode-base-map "\'" 'electric-pair)
	    (define-key c++-mode-base-map "(" 'electric-pair)
	    (define-key c++-mode-base-map "[" 'electric-pair)
	    (define-key c++-mode-base-map "{" 'electric-pair)
	    ;; TAB はスペース 2 個ぶんで
	    (setq-default tab-width 2)
	    (setq indent-tabs-mode nil)
	    ;; # をインデントしない
	    (setq c-electric-pound-behavior '(alignleft))
	    (c-set-offset 'cpp-macro 0)
	    (c-set-offset 'cpp-macro-cont '+)
	    (setq-default ac-sources c++-ac-sources)
	    (flycheck-mode t)
	    (gtags-mode 1)
	    ))

;; update GTAGS
(defun update-gtags (&optional prefix)
  (interactive "P")
  (let ((rootdir (gtags-get-rootpath))
        (args (if prefix "-v" "-iv")))
    (when rootdir
      (let* ((default-directory rootdir)
             (buffer (get-buffer-create "*update GTAGS*")))
        (save-excursion
          (set-buffer buffer)
          (erase-buffer)
          (let ((result (process-file "gtags" nil buffer nil args)))
            (if (= 0 result)
                (message "GTAGS successfully updated.")
              (message "update GTAGS error with exit status %d" result))))))))
(add-hook 'after-save-hook 'update-gtags)
