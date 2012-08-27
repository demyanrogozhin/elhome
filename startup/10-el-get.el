(add-to-list 'load-path (expand-file-name (elhome-path-join user-emacs-directory "el-get" "el-get")))

;; Install el-get if necessary
(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
    (end-of-buffer)
    (eval-print-last-sexp)))

;; For some reason, el-get doesn't automatically init what you install anymore
;(add-hook 'el-get-post-install-hooks 'el-get-init)

(el-get)
