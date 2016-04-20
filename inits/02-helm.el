(require 'helm-config)
(helm-mode 1)

(require 'helm-ag)
(setq helm-ag-base-command "ag --nocolor --nogrou")

;;(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil)) ;;普通にfind fileする

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

(defvar helm-source-emacs-commands
  (helm-build-sync-source "Emacs commands"
    :candidates (lambda ()
                  (let ((cmds))
                    (mapatoms
                     (lambda (elt) (when (commandp elt) (push elt cmds))))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "A simple helm source for Emacs commands.")

(defvar helm-source-emacs-commands-history
  (helm-build-sync-source "Emacs commands history"
    :candidates (lambda ()
                  (let ((cmds))
                    (dolist (elem extended-command-history)
                      (push (intern elem) cmds))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "Emacs commands history")

(custom-set-variables
 '(helm-mini-default-sources '(helm-source-buffers-list
                               helm-source-recentf
                               helm-source-locate
                               helm-source-files-in-current-dir
                               helm-source-emacs-commands-history
                               helm-source-emacs-commands
                               )))
(setq helm-find-files-sort-directories t)
