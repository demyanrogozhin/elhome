(add-to-list 'load-path (expand-file-name (elhome-path-join user-emacs-directory "el-get" "el-get")))

;; Install el-get if necessary
(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
    (end-of-buffer)
    (eval-print-last-sexp)))

(save-excursion
  (find-function 'el-get-build)
  (edebug-defun))

(el-get)
