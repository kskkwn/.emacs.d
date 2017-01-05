(require 'package)
;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; Marmaladeを追加
;(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/"))
;; 初期化
(package-initialize)

;; Linuxの場合
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c7a9a68bd07e38620a5508fef62ec079d274475c8f92d75ed0c33c45fbe306bc" "10e231624707d46f7b2059cc9280c332f7c7a530ebc17dba7e506df34c5332c4" "d320493111089afba1563bc3962d8ea1117dd2b3abb189aeebdc8c51b5517ddb" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default)))
 '(desktop-save-mode t)
 '(helm-mini-default-sources
   (quote
    (helm-source-buffers-list helm-source-recentf helm-source-locate helm-source-files-in-current-dir helm-source-emacs-commands-history helm-source-emacs-commands)))
 '(package-selected-packages
   (quote
    (telephone-line smart-mode-line-powerline-theme yatex yasnippet windata web-mode use-package undohist undo-tree tabbar switch-window stan-mode smooth-scroll smex smartparens py-autopep8 projectile prodigy powerline popwin pallet nyan-mode multiple-cursors magit magic-latex-buffer idle-highlight-mode htmlize helm git-gutter flycheck-cask expand-region exec-path-from-shell ein drag-stuff anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;~/.emacs.d/inits/ 以下を読み込み
(require 'init-loader)
;;(setq init-loader-show-log-after-init 'error-only);; errorがあるときだけログ表示
(init-loader-load "~/.emacs.d/inits")

(set-frame-parameter nil 'fullscreen 'fullboth)
