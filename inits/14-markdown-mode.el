(add-hook 'markdown-mode-hook
          '(lambda()
             (define-key markdown-mode-map "\C-c\C-c" 'org-toggle-latex-fragment)))
