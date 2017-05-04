(add-hook
 'c++-mode-hook
 '(lambda ()
    (flycheck-mode t)
    (my-irony-mode)
    ))

(defun my-irony-mode ()
  (eval-after-load "irony"
    '(progn
       (custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
       (add-to-list 'company-backends 'company-irony)
       (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
       (add-hook 'c-mode-common-hook 'irony-mode)))

  (eval-after-load "flycheck"
    '(progn
       (when (locate-library "flycheck-irony")
         (flycheck-irony-setup))))

  (flycheck-add-next-checker 'irony '(warning . c/c++-googlelint)))
