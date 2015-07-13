(require 'auto-complete)
(require 'auto-complete-config)
(setq ac-use-menu-map t)
(define-key ac-menu-map (kbd "C-n")         'ac-next)
(define-key ac-menu-map (kbd "C-p")         'ac-previous)

(global-auto-complete-mode t)
;; 追加メジャーモード
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'cuda-mode)

