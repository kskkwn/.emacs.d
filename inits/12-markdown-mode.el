(defun my-flymd-browser-function (url)
  (let ((browse-url-browser-function 'browse-url-firefox))
    (browse-url url)))

(add-hook
 'markdown-mode-hook
 '(lambda ()
    (setq flymd-browser-open-function 'my-flymd-browser-function)
    ))
