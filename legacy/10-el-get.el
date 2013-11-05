(add-to-list 'load-path (expand-file-name (elhome-path-join user-emacs-directory "el-get" "el-get")))

;; Install el-get if necessary
(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp))
  )

(defun elhome-el-get-is-running ()
  "Check to see if el-get is already running.

If el-get invoked elhome, and then elhome invokes el-get, we get
a bad recursion.

On the other hand, some people prefer to have elhome manage
el-get. In this case, el-get won't show up in the call stack, so
we can invoke it ourselves."
  (let ((n 0)
        (found nil))
    (while (and (not found) (backtrace-frame n))
      (let* ((frame (backtrace-frame n))
             (function (cadr frame)))
        (let ((function-name (cond
                              ((stringp function) function)
                              ((symbolp function) (symbol-name function))
                              ((listp function) "")  ; lambda
                              ((eq (type-of function) 'compiled-function) "")
                              (t (progn
                                   (message "unknown form of backtrace frame %s"
                                            frame)
                                   "")))))
          (setq found (string-match "^el-get" function-name))))
      (setq n (+ 1 n)))
  found))

(when (not (elhome-el-get-is-running))
    (el-get))
