(defun my-jedi-mode-setup ()
  (require 'jedi-core)
  (setq jedi:complete-on-dot t)
  (setq jedi:use-shortcuts t)
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-to-list 'company-backends 'company-jedi)) ; backendに追加


(defun my-python-mode-setup ()
  (require 'py-autopep8)
  (setq py-autopep8-options '("--max-line-length=200"))
  (py-autopep8-enable-on-save)

  ;;errorやwarningを表示する
  (flymake-mode t)
  (require 'flymake-python-pyflakes)
  (flymake-python-pyflakes-load)
  (highlight-numbers-mode t)
  (yas-global-mode 1)
  )

(defun set-python-keybinds ()
  (bind-keys :map python-mode-map
           ("C-c t" . jedi:goto-definition)
           ("C-c b" . jedi:goto-definition-pop-marker)
           ("C-c r" . helm-jedi-related-names)
           ("C-c C-c" . quickrun)))

(add-hook
 'python-mode-hook
 '(lambda ()
    (my-jedi-mode-setup)
    (my-python-mode-setup)
    (set-python-keybinds)
    (smartparens-mode)
    (company-mode)
    ))
