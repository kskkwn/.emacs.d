(add-hook
 'LaTeX-mode-hook
 '(lambda ()
    (magic-latex-buffer)
    (reftex-mode t)
    (smartparens-mode)
    ))


