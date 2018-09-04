;;; package --- Summary
;;
;; This package was created to mimic the recursive block highlight functionality
;; found in Wolfram Mathematica
;;
;; author: Gergely Horváth

;;; Commentary:
;;


;;; Code:
(defvar mathematica-navigation-pre-highlight-parenthesis-block-positions '(("*scratch*" . 1)) "Position before highlight.")

(defun mathematica-navigation-highlight-parenthesis-block ()
  "As in Wolfram Mathematica, mark and highlight a whole parenthesis block.
Pressed multiple times, goes upper one level."
  (interactive)
  (if (eq last-command this-command) nil
    (if (assoc (current-buffer) mathematica-navigation-pre-highlight-parenthesis-block-positions)
	(setf (cdr (assoc (current-buffer) mathematica-navigation-pre-highlight-parenthesis-block-positions)) (point))
      (setcdr (last mathematica-navigation-pre-highlight-parenthesis-block-positions) (list (cons (current-buffer) (point) )) )
      )
    )
  (backward-up-list)
  (set-mark-command nil)
  (forward-list)
  )

(defun mathematica-navigation-goto-position-before-highlight ()
  "Jump back to the last position before highlighting parenthesis block."
  (interactive)
  (goto-char (cdr (assoc (current-buffer) mathematica-navigation-pre-highlight-parenthesis-block-positions)))
  )

;;; Default key-bindings
(global-set-key (kbd "C-.") 'mathematica-navigation-highlight-parenthesis-block)
(global-set-key (kbd "C-,") 'mathematica-navigation-goto-position-before-highlight)

(provide 'mathematica-navigation)
;;; mathematica-navigation ends here
