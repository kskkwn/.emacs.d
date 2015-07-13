;; capture templates
(setq org-capture-templates
      '(("p" "Project Task" entry (file+headline (expand-file-name "~/project/project.org") "Inbox")
             "** TODO %?\n    %i\n    %a\n    %T")
        ("m" "memo" entry (file (expand-file-name "~/memo.org"))
             "* %?\n    %i\n    %a\n    %T")))

;; agenda
(setq org-agenda-files (list (expand-file-name "~/project")))

;; C-tab はタブの移動に使いたいのではずす
(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map [(control tab)] nil)))
