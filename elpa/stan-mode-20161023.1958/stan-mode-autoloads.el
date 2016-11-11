;;; stan-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "stan-mode" "stan-mode.el" (22553 59066 500735
;;;;;;  747000))
;;; Generated autoloads from stan-mode.el

(autoload 'stan-mode "stan-mode" "\
A major mode for editing Stan files.

The hook `c-mode-common-hook' is run with no args at mode
initialization, then `stan-mode-hook'.

Key bindings:
\\{stan-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.stan\\'" . stan-mode))

;;;***

;;;### (autoloads nil nil ("stan-keywords-lists.el" "stan-mode-pkg.el")
;;;;;;  (22553 59066 488735 747000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; stan-mode-autoloads.el ends here
