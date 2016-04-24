(add-hook 'python-mode-hook
	  '(lambda ()
	     (require 'py-autopep8)
	     (setq py-autopep8-options '("--max-line-length=200"))
	     (setq flycheck-flake8-maximum-line-length 200)
         (py-autopep8-enable-on-save)

	     ;;quick-run
	     ;;(require 'quickrun)
	     ;; 結果の出力バッファと元のバッファを行き来したい場合は
	     ;; ':stick t'の設定をするとよいでしょう
	     ;;(push '("*quickrun*") popwin:special-display-config)

         ;;http://txt.arboreus.com/2013/02/21/jedi.el-jump-to-definition-and-back.html
  	     (defvar jedi:goto-stack '())
	     (defun jedi:jump-to-definition ()
	       (interactive)
	       (add-to-list 'jedi:goto-stack
			    (list (buffer-name) (point)))
	       (jedi:goto-definition))
	     (defun jedi:jump-back ()
	       (interactive)
	       (let ((p (pop jedi:goto-stack)))
		 (if p ((progn )
			(switch-to-buffer (nth 0 p))
			(goto-char (nth 1 p))))))

	     (setq indent-tabs-mode nil);;tabの幅を変える
	     (setq indent-level 4)
	     (setq python-indent 4)
	     (setq tab-width 4)
	     (define-key python-mode-map "\"" 'electric-pair) ;;括弧の補完
	     (define-key python-mode-map "\'" 'electric-pair)
	     (define-key python-mode-map "(" 'electric-pair)
	     (define-key python-mode-map "[" 'electric-pair)
	     (define-key python-mode-map "{" 'electric-pair)
	     (define-key python-mode-map "\C-ct" 'jedi:jump-to-definition)
	     (define-key python-mode-map "\C-cb" 'jedi:jump-back)
	     (define-key python-mode-map "\C-cr" 'helm-jedi-related-names)
	     (auto-complete-mode t)
	     (flycheck-mode t)
	     (global-set-key (kbd "C-c C-c") 'quickrun)


	     ;; jedi
	     (jedi:setup)
	     (define-key jedi-mode-map (kbd "<C-tab>") nil) ;;C-tabはウィンドウの移動に用いる
	     (setq jedi:complete-on-dot t)
	     (define-key jedi-mode-map (kbd "C-j") 'jedi:complete)
	     (define-key jedi-mode-map "." 'jedi:dot-complete) ;;本来は不要．ドットを打っても上手く補完されなかったので追加した．
	     (setq ac-sources
               (delete 'ac-source-words-in-same-mode-buffers ac-sources)) ;;jediの補完候補だけでいい
         (add-to-list 'ac-sources 'ac-source-filename)
	     (add-to-list 'ac-sources 'ac-source-jedi-direct)

	     (yas-global-mode 1)
	     ))
