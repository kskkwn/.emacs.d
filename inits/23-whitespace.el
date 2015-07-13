;;保存時に行末のスペースを削除．文末の改行は削除しない
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

;;全角のスペースを目立たせる 　　<-こんな感じ
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))

