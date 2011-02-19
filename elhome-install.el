(progn
       
  ;; Set up everything needed for elhome
  (defun elhome-setup () 
    (message "Switching to dabrahams' el-get...")

    ;; warning: do *NOT* try to factor this out, even though it looks
    ;; like code repetition
    (let* ((default-directory
            (concat (file-name-as-directory user-emacs-directory) 
                    "el-get/el-get/"))
           (git (executable-find "git")))

      (unless (zerop (call-process git nil nil t 
                        "remote" "set-url" "origin" 
                        "https://github.com/dabrahams/el-get.git"))
          (error "unable to point origin at dabrahams' el-get"))
      (unless (zerop (call-process git nil nil t "fetch" "origin"))
          (error "unable to fetch from dabrahams/el-get"))
      (unless (zerop (call-process git nil nil t "checkout" "origin/master"))
          (error "unable to checkout dabrahams' master"))

      (load-library "el-get")

      (message "Grabbing elhome dependencies...")
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

        (save-window-excursion
          (el-get 'sync))

        (with-current-buffer
            (find-file-noselect
             (concat
              (file-name-as-directory user-emacs-directory) 
              "el-get/elhome/README.markdown"))
          (goto-char (point-max))
          (search-backward "## Congratulations")
          (switch-to-buffer (current-buffer))
          (recenter 'top))
        (message "Thank you for installing elhome!")
        )))
  
  (add-to-list 'load-path
               (concat (file-name-as-directory user-emacs-directory) 
                       "el-get/el-get/"))

  (if (require 'el-get nil t)
      (elhome-setup)
    (url-retrieve
     ;; Use an el-get installer that grabs from my own repo.
     "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
     (lambda (s) (end-of-buffer) (eval-print-last-sexp) (elhome-setup)))))
