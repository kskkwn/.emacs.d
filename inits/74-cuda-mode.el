(add-hook 'cuda-mode-common-hook
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
