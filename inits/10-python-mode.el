(defun my-jedi-mode-setup ()
  (require 'jedi-core)
  (setq jedi:complete-on-dot t)
  (setq jedi:use-shortcuts t)
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-to-list 'company-backends 'company-jedi) ; backendに追加

  (setq ac-sources
	(delete 'ac-source-words-in-same-mode-buffers ac-sources)) ;;jediの補完候補だけでいい
  (add-to-list 'ac-sources 'ac-source-filename)
  (add-to-list 'ac-sources 'ac-source-jedi-direct))

(defun my-python-mode-setup ()
  (require 'py-autopep8)
  (setq py-autopep8-options '("--max-line-length=200"))
  (py-autopep8-enable-on-save)

  ;;errorやwarningを表示する
  (flymake-mode t)
  (require 'flymake-python-pyflakes)
  (flymake-python-pyflakes-load)

  (yas-global-mode 1)
  )

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
    ;;(highlight-indent-guides-mode)
    (smartparens-mode)
    ))
