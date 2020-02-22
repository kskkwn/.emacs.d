;; alias emacs="emacsclient -n"
(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)

;;~/.emacs.d/inits/ 以下を読み込み
(require 'init-loader)
;; errorがあるときだけログ表示
(setq init-loader-show-log-after-init 'error-only)
(init-loader-load "~/.emacs.d/inits")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0)
 '(desktop-save-mode t)
 '(helm-mini-default-sources
   (quote
    (helm-source-buffers-list helm-source-recentf helm-source-locate helm-source-files-in-current-dir helm-source-emacs-commands-history helm-source-emacs-commands))))
