;; Copyright David Abrahams 2010. Distributed under the Boost
;; Software License, Version 1.0. (See accompanying
;; file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

;; Contains all the very basic stuff I need in order to not tear my
;; hair out when using Emacs; mostly keybindings.  This file gets
;; loaded very early in case something goes wrong during startup and I
;; end up in the debugger: the environment should already be
;; relatively good.

;; Navigation by words
(global-set-key [(control ?,)] 'backward-word)
(global-set-key [(control ?.)] 'forward-word)

;; Navigation to other windows (panes)
(global-set-key "\C-x\C-n" 'other-window)  ; Normally bound to set-goal-column

(defun dwa/other-window-backward (&optional n)
  "Select the previous window. Copied from \"Writing Gnu Emacs Extensions\"."
  (interactive "P")
  (other-window (- (or n 1)))
  )

(global-set-key "\C-x\C-p" 'dwa/other-window-backward) ; Normally bound to mark-page

;; This is the way I like it; the defaults go to the beginning and/or end of line
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)

(defun dwa/match-paren (arg)
  (interactive "P")
  (if arg
      () ;;(insert "%")  ; insert the character we're bound to
    (cond ((looking-at "[[({]")
           (forward-sexp 1)
           (forward-char -1))
          ((looking-at "[]})]")
           (forward-char 1)
           (forward-sexp -1))
          (t
           ;; (insert "%")  ; insert the character we're bound to
      ))))

(global-set-key [( control ?\( )] 'dwa/match-paren)

(defun dwa/other-buffer ()
  "Switch to the most recently visited buffer without asking"
  (interactive)
  (switch-to-buffer nil))

;; This is normally set to bring up a buffer list, but there are many other
;; ways to do this seldom-desired function (e.g. C-mouse1, or look at the
;; "Buffers" menu at the top of the frame).
(global-set-key "\C-x\C-b" 'dwa/other-buffer)

;; Miscellaneous
(global-set-key "\C-x\C-g" 'goto-line)

(defun dwa/kill-current-buffer ()
  "Kill the current buffer without asking, unless it's modified file, in which case ask first"
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key "\C-x\C-k" 'dwa/kill-current-buffer)

(if (eq system-type 'darwin)
    ;; This is not important enough to abort startup on failure
    (ignore-errors
      (require 'osx-plist)
      (osx-plist-update-environment)))
