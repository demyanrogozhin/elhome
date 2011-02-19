(progn
  (setq debug-on-error t)
  (defun elhome-setup () 
    (let ((el-get-sources 
           '(el-get
             (:name initsplit
                    :type git
                    :url "git://github.com/dabrahams/initsplit.git"
                    :features initsplit)
             byte-code-cache
             markdown-mode
             (:name elhome
                    :type git
                    :url "git://github.com/dabrahams/elhome.git"
                    :features elhome))))
      (el-get 'sync)
      (find-file-read-only
       (concat
        (file-name-as-directory user-emacs-directory) 
        "el-get/elhome/README.mkd"))
      (markdown-mode)
      (message "Thank you for installing elhome")
      ))
  
  (add-to-list 'load-path (concat
                           (file-name-as-directory user-emacs-directory) 
                           "el-get/el-get"))
  (if (require 'el-get nil t)
      (elhome-setup)
    (url-retrieve
     "https://gist.github.com/raw/834740/9bd42b0f9508ed4dd278b3ff82059688660582d6/el-get-install.el"
     (lambda (s) (end-of-buffer) (eval-print-last-sexp) 
       (elhome-setup)))))