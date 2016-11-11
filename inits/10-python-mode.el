(defun my-jedi-mode-setup ()
  (jedi:setup)
  (setq jedi:complete-on-dot t)
  (setq ac-sources
	(delete 'ac-source-words-in-same-mode-buffers ac-sources)) ;;jediの補完候補だけでいい
  (add-to-list 'ac-sources 'ac-source-filename)
  (add-to-list 'ac-sources 'ac-source-jedi-direct))

(defun my-python-mode-setup ()
  (require 'py-autopep8)
  (setq py-autopep8-options '("--max-line-length=200")) ;;TODO どっちかでいいのでは
  (setq flycheck-flake8-maximum-line-length 200)
  (py-autopep8-enable-on-save)

  ;;errorやwarningを表示する
  ;; (require 'flycheck-pyflakes)
  ;; (add-hook 'python-mode-hook 'flycheck-mode) ;;warningとerrorの表記の差がなかったのでやめた
  (flycheck-mode t)
  (require 'flymake-python-pyflakes)
  (flymake-python-pyflakes-load)

  (setq python-shell-interpreter "/usr/bin/python")

  (yas-global-mode 1)
  (auto-complete-mode t))

(defun set-python-keybinds ()
  (define-key jedi-mode-map (kbd "<C-tab>") nil) ;;C-tabはウィンドウの移動に用いる
  (global-set-key (kbd "C-c C-c") 'quickrun)
  (define-key python-mode-map "\C-ct" 'jedi:goto-definition)
  (define-key python-mode-map "\C-cb" 'jedi:goto-definition-pop-marker)
  (define-key python-mode-map "\C-cr" 'helm-jedi-related-names))

(add-hook
 'python-mode-hook
 '(lambda ()
    (my-jedi-mode-setup)
    (my-python-mode-setup)
    (set-python-keybinds)
    (smartparens-mode)))





