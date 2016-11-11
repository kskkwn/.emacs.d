(require 'magic-latex-buffer)
(add-hook 'latex-mode-hook 'magic-latex-buffer)

(setq magic-latex-enable-block-highlight nil
      magic-latex-enable-suscript        t
      magic-latex-enable-pretty-symbols  t
      magic-latex-enable-block-align     nil
      magic-latex-enable-inline-image    t
      magic-latex-enable-minibuffer-echo nil)

;;自動改行を抑制 これがないと長い文章のよくわからないところで改行される
(add-hook ' latex-mode-hook
'(lambda () (auto-fill-mode -1)))

(add-hook 'yatex-mode-hook '(lambda () (reftex-mode t)))
;;(add-hook 'latex-mode-hook 'turn-on-reftex)
