(let ((el-get-sources 
       '(el-get
         (:name elhome
                  :type git
                  :url "git://github.com/dabrahams/elhome.git"
                  :features elhome))))

  (unless (require 'el-get nil t)
    (url-retrieve
     "https://github.com/dabrahams/el-get/raw/master/el-get-install.el"
     (lambda (s) (end-of-buffer) (eval-print-last-sexp))))

  (el-get))
