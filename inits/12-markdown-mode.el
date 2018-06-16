(require 'org)
;; (require 'flycheck)
;; (flycheck-define-checker textlint
;;   "A linter for prose."
;;   :command ("textlint" "--format" "unix" source-inplace)
;;  :error-patterns
;;   ((warning line-start (file-name) ":" line ":" column ": "
;;             (id (one-or-more (not (any " "))))
;;             (message (one-or-more not-newline)
;;                      (zero-or-more "\n" (any " ") (one-or-more not-newline)))
;;             line-end))
;;   :modes (text-mode markdown-mode))

;; (add-to-list 'flycheck-checkers 'textlint)
;; (add-hook 'markdown-mode-hook 'flycheck-mode)

(defun my-flymd-browser-function (url)
  (let ((browse-url-browser-function 'browse-url-firefox))
    (browse-url url)))

;; http://qiita.com/nanasess/items/c9342c06a3e28e64aeb8
(defun cleanup-org-tables ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "-+-" nil t) (replace-match "-|-"))))

(add-hook 'markdown-mode-hook 'orgtbl-mode)
(add-hook 'markdown-mode-hook
          #'(lambda()
              (add-hook 'after-save-hook 'cleanup-org-tables  nil 'make-it-local)
              (setq flymd-browser-open-function 'my-flymd-browser-function)
              (set (make-local-variable 'whitespace-action) nil)

              (highlight-numbers-mode -1)
              (company-mode -1)
              ))

;;(setq markdown-preview-stylesheets (list "http://thomasf.github.io/solarized-css/solarized-light.min.css"))
