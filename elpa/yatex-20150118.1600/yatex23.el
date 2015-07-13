;;; yatex23.el --- YaTeX facilities for Emacs 23 or later -*- coding: sjis -*-
;;; (c)2014 by HIROSE Yuuji.[yuuji@yatex.org]
;;; Last modified Tue Dec 23 12:44:35 2014 on firestorm
;;; $Id$

;;; Code:
(defvar YaTeX-dnd-auto-figure "figure"
  "*If set, include dropped \\includegraphcs{} into that environment.
The value should be string.  Set this `nil' to disable enclosing.")
(defvar YaTeX-dnd-auto-figure-package
  (cons "graphicx"
	(cond ((string-match "pdflatex" tex-command) "pdftex")
	      (t "dvipdfmx")))
  "*Default LaTeX package and its option for \\includegraphics")

(defun YaTeX-dnd-handler (uri action)
  "DnD handler for yatex-mode
Convert local image URI to \\includegraphcis{} and
.tex file names to \\include{}."
  (let*((file (dnd-get-local-file-name uri))
	(path (save-excursion
		(YaTeX-visit-main t)
		(file-relative-name file)))
	(insert-file-directory nil)
	(case-fold-search t)
	(b nil) p1 p2 (cc (current-column)) envstart)
    (cond
     ((memq action '(copy link move private))
      (cond
       ((string-match "\\.\\(jpe?g\\|png\\|gif\\|bmp\\|tiff?\\|e?ps\\|pdf\\)$" path)
	(if (and (stringp YaTeX-dnd-auto-figure)
		 (not (YaTeX-in-environment-p YaTeX-dnd-auto-figure))
		 (not (string-match "figure"
				    (or (YaTeX-inner-environment t) "body")))
		 YaTeX-dnd-auto-figure)
	    (setq b (format "\\begin{%s}[htbp] %%\\centering\n"
			    YaTeX-dnd-auto-figure)))
	(unwind-protect
	    (progn
	      (setq envstart (point-marker))
	      (insert "\\includegraphics")
	      (insert "{" (YaTeX::includegraphics 1 path t) "}")
	      (save-excursion
		(YaTeX-package-auto-usepackage
		 "includegraphics" 'section
		 (car YaTeX-dnd-auto-figure-package)
		 (cdr YaTeX-dnd-auto-figure-package)))
	      (cond
	       (b
		(undo-boundary)
		(save-excursion
		  (goto-char envstart)
		  (insert b))
		(YaTeX-indent-line)
		(insert "\n")
		(indent-to (1+ cc))
		(setq p1 (point))
		(insert "\\caption{")
		(setq p2 (point))
		(insert (format "}\\label{%s}\n" path))
		(indent-to cc)
		(insert (format "\\end{%s}\n" YaTeX-dnd-auto-figure))
		(goto-char p2)
		(undo-boundary)
		(insert (file-name-nondirectory path))
		(undo-boundary)
		(goto-char p1)
		(insert "%")
		(end-of-line)
		(or (get 'YaTeX-dnd-auto-figure 'guide)
		    (progn
		      (newline 1)
		      (indent-to (1+ cc))
		      (insert (format
			       (if YaTeX-japan
				   "%% Undo(%s)Ç∑ÇÈÇ∆captionÇ™äàÇ´Ç‹Ç∑ÅB2ìxâüÇµÇ≈ãÛóì 3ìxâüÇµÇ≈ñ≥ä¬ã´"
				 "%% TYPE undo(%s) to ACTIVATE caption.  Twice to clear caption. 3 to no-env")
			       (key-description
				(car (where-is-internal 'undo)))))
		      (put 'YaTeX-dnd-auto-figure 'guide t)))))
	      (YaTeX-help "includegraphics"))
	  (set-marker envstart nil) ;;sure to reset marker
	  action))
       ((string-match "\\(.*\\)\\.tex$" path)
	(insert "\\include{" (match-string 1 path) "}"))
       ((string-match "\\(.*\\)\\.bib$" path)
	(insert "\\bibliography{" (match-string 1 path) "}"))
       ((string-match "\\.ind$" path)
	(insert "\\input{" path "}"))))
     (t (message "%s" action)))))

(provide 'yatex23)

; Local variables:
; fill-prefix: ";;; "
; paragraph-start: "^$\\|\\|;;;$"
; paragraph-separate: "^$\\|\\|;;;$"
; coding: sjis
; End:
