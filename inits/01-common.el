(exec-path-from-shell-initialize)

;; http://syohex.hatenablog.com/entry/20101224/1293206906
;; start emacs with server mode
(require 'server)
(unless (server-running-p)
  (server-start))

;; start with scratch window
(setq inhibit-startup-message t)

;; http://yohshiy.blog.fc2.com/blog-entry-319.html
(setq make-backup-files nil)
(setq delete-auto-save-files t)

;; open file and dir ignoring capital of not
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)


(fset 'yes-or-no-p 'y-or-n-p) ; yes/no -> y/n
(setq kill-whole-line t) ; erase newlines on EOL with C-k
(define-key global-map [?¥] [?\\]) ; use backslash instead of Japanese yen
(global-auto-revert-mode 1)

;; scroll buffer on compile window
(setq compilation-scroll-output t)

;; use undohist
(when (require 'undohist nil t)
  (undohist-initialize)
  (setq undohist-ignored-files '("/tmp" "/EDITMSG" "/elpa"))
)

;; undo tree
(require 'undo-tree)
(global-undo-tree-mode t)

;; git mode on emacs
(require 'magit)
(define-key magit-mode-map (kbd "<C-tab>") nil) ;; unset magit keybind C-tab

;; insert pairs e.g., "()"
(require 'smartparens-config)

;; http://qiita.com/itiut@github/items/4d74da2412a29ef59c3a
;; erase spaces on EOF when saving
(require 'whitespace)
(set-face-foreground 'whitespace-space "DarkGoldenrod1")
(set-face-background 'whitespace-space nil)
(set-face-bold-p 'whitespace-space t)
(setq whitespace-style '(tabs           ; タブ
                         trailing       ; 行末
                         spaces         ; スペース
                         space-mark     ; 表示のマッピング
                         ;;                         tab-mark
                         ))
(setq whitespace-action '(auto-cleanup))
(global-whitespace-mode 1)


;; use four spaces instead of tabs
(setq-default tab-width 4 indent-tabs-mode nil)

;; 検索時に件数を表示する
(require 'anzu)
(global-anzu-mode 1)

;;再起動時に色々復元
(custom-set-variables
 '(desktop-save-mode t))
(custom-set-faces)


;; yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ;; 作成するスニペットはここに入る
        ))
(yas-global-mode 1)

(smartparens-global-mode)

(require 'git-gutter)
(require 'git-gutter-fringe)
(global-git-gutter-mode)
(setq git-gutter:update-hooks '(after-save-hook after-revert-hook))

(require 'iedit)

;; (require 'mozc)
;; (set-language-environment "Japanese")
;; (setq default-input-method "japanese-mozc")

;; company mode http://qiita.com/sune2/items/b73037f9e85962f5afb7
(require 'company)
(custom-set-variables
 '(company-idle-delay 0))
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(global-company-mode t)

(require 'company-quickhelp)
(company-quickhelp-mode +1)


;; perspeen mode
(require 'perspeen)
(perspeen-mode)

(custom-set-faces
 '(perspeen-selected-face
   ((t (:weight bold :foreground "#ff8700")))
   ))

(require 'helm-perspeen)

;; no sound required
(setq ring-bell-function 'ignore)

;; http://kiyotakagoto.hatenablog.com/entry/2013/06/04/003605
(defun align-regexp-repeated (start stop regexp)
  "Like align-regexp, but repeated for multiple columns. See
http://www.emacswiki.org/emacs/AlignCommands"
  (interactive "r\nsAlign regexp: ")
  (let ((spacing 1)
        (old-buffer-size (buffer-size)))
    ;; If our align regexp is just spaces, then we don't need any
    ;; extra spacing.
    (when (string-match regexp " ")
      (setq spacing 0))
    (align-regexp start stop
                  ;; add space at beginning of regexp
                  (concat "\\([[:space:]]*\\)" regexp)
                  1 spacing t)
    ;; modify stop because align-regexp will add/remove characters
    (align-regexp start (+ stop (- (buffer-size) old-buffer-size))
                  ;; add space at end of regexp
                  (concat regexp "\\([[:space:]]*\\)")
                  1 spacing t)))

(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
 '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
