;; http://d.hatena.ne.jp/a_bicky/20140104/1388822688
(require 'helm-config)
(require 'helm-ag)

(helm-mode 1)
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


;;http://www49.atwiki.jp/ntemacs/pages/32.html
(setq helm-locate-command
      ;; (concat "locate_case=$(echo '%s' | sed 's/-//'); cat /tmp/all.filelist |"
      (concat "locate_case=$(echo '%s' | sed 's/-//'); locate '' |"
              "perl -ne \"$(echo '%s' |"
                           "sed -r -e 's/[\\\\ ] /__SpAcE__/g' "
                                  "-e 's/^ +//' "
                                  "-e 's/ +$//' "
                                  "-e 's_/_\\\\&_g' "
                                  "-e 's_ +_/'$locate_case' \\&\\& m/_g' "
                                  "-e 's_.*_$| = 1; print if (m/&/'$locate_case')_' "
                                  "-e 's_m/!_!m/_g' "
                                  "-e 's/__SpAcE__/ /g')\" 2> /dev/null |"
              "head -n " (number-to-string helm-candidate-number-limit)))


;;http://d.hatena.ne.jp/a_bicky/20140104/1388822688
(defadvice helm-ff-transform-fname-for-completion (around my-transform activate)
  "Transform the pattern to reflect my intention"
  (let* ((pattern (ad-get-arg 0))
         (input-pattern (file-name-nondirectory pattern))
         (dirname (file-name-directory pattern)))
    (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
    (setq ad-return-value
          (concat dirname
                  (if (string-match "^\\^" input-pattern)
                      ;; '^' is a pattern for basename
                      ;; and not required because the directory name is prepended
                      (substring input-pattern 1)
                    (concat ".*" input-pattern))))))
