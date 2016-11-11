(require 'package)
;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; Marmaladeを追加
;(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/"))
;; 初期化
(package-initialize)

;;~/.emacs.d/inits/ 以下を読み込み
(require 'init-loader)
;;(setq init-loader-show-log-after-init 'error-only);; errorがあるときだけログ表示
(init-loader-load "~/.emacs.d/inits")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(desktop-save-mode t)
 '(helm-mini-default-sources
   (quote
    (helm-source-buffers-list helm-source-recentf helm-source-locate helm-source-files-in-current-dir helm-source-emacs-commands-history helm-source-emacs-commands)))
 '(package-selected-packages
   (quote
    (magic-latex-buffer yatex flymake-python-pyflakes iedit anzu magit windata smartparens yasnippet flycheck-pyflakes py-autopep8 jedi ess stan-mode helm-ag powerline helm tabbar diminish init-loader darktooth-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

