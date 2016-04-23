;; YaTeX
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist (append
  '(("\\.tex$" . yatex-mode)
    ("\\.ltx$" . yatex-mode)
    ("\\.cls$" . yatex-mode)
    ("\\.sty$" . yatex-mode)
    ("\\.clo$" . yatex-mode)
    ("\\.bbl$" . yatex-mode)) auto-mode-alist))

;;自動改行を抑制 これがないと長い文章のよくわからないところで改行される
(add-hook ' yatex-mode-hook
'(lambda () (auto-fill-mode -1)))

;; RefTexという参考文献とかを補完するモードをONにする 使い方がよくわかってないので調べる
(add-hook 'yatex-mode-hook
          #'(lambda ()
              (reftex-mode 1)
              (define-key reftex-mode-map
                (concat YaTeX-prefix ">") 'YaTeX-comment-region)
              (define-key reftex-mode-map
                (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)
	      ))


;;YaTeXのいろいろをAutoCompleteの補完リストに追加する
;;snippetsは"\"いらないけど，ACは"\" も打たないと補完されない 変えたほうがいい？
;; for YaTeX
(require 'auto-complete-latex)
(setq ac-l-dict-directory "~/.emacs.d/site-lisp/ac-l-dict/")
(add-to-list 'ac-modes 'yatex-mode)
(add-hook 'yatex-mode-hook 'ac-l-setup)
(add-to-list 'ac-modes 'foo-mode)
(add-hook 'foo-mode-hook 'ac-l-setup)

(add-hook 'yatex-mode-hook
          #'(lambda ()
	      (define-key YaTeX-mode-map (kbd "C-c c") 'compile) ;;C-c c でmake できるようにする
	      (auto-complete-mode t)
	      ))


;;以下研究室のやつをコピペした 使い方を知っていりそうなら入れる
;;; RefTeXをYaTeXで使えるようにする
;;(add-hook 'yatex-mode-hook '(lambda () (reftex-mode t)))
;;; RefTeXで使うbibファイルの位置を指定する
;;;(setq reftex-default-bibliography '("~/Library/TeX/bib/papers.bib"))
;;;;bibファイルのある場所を指定するらしい
;;(setq reftex-default-bibliography '("~/Dropbox/rsyncToServer/syuron/references.bib"))
;;
;;;;RefTeXに関する設定
;;(setq reftex-enable-partial-scans t)
;;(setq reftex-save-parse-info t)
;;(setq reftex-use-multiple-selection-buffers t)
;;
;;;;RefTeXにおいて数式の引用を\eqrefにする
;;(setq reftex-label-alist '((nil ?e nil "~\\eqref{%s}" nil nil)))

;; utf8で書く
(setq YaTeX-kanji-code 4)
