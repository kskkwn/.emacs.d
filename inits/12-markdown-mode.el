(require 'org)

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

              (highlight-numbers-mode t)
              ))
