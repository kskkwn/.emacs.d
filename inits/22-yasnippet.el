(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/elpa/yasnippet-0.8.0/snippets"
        ))
(yas-global-mode 1)

;;; yasnippetのbindingを指定するとエラーが出るので回避する方法。
(setf (symbol-function 'yas-active-keys)
      (lambda ()
        (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))

(defalias 'yas/get-snippet-tables 'yas--get-snippet-tables)
(defalias 'yas/table-hash 'yas--table-hash)

