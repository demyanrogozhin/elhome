(progn
  (defun el-get-subdir (&rest d)
    (mapconcat 'file-name-as-directory
               (append (list user-emacs-directory "el-get") d) ""))

  (defun elhome-setup () 
    (message "Switching to dabrahams' el-get...")

    ;; warning: do *NOT* try to factor this out, even though it looks
    ;; like code repetition
    (let* ((default-directory (el-get-subdir "el-get"))
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
             '((:name el-get :compile nil)
               (:name initsplit :compile nil)
               byte-code-cache
               markdown-mode
               elhome)))

        (save-window-excursion
          (el-get 'sync))

        (with-current-buffer
            (find-file-noselect
             (concat (el-get-subdir "elhome") "README.markdown"))
          (goto-char (point-max))
          (search-backward "## Congratulations")
          (switch-to-buffer (current-buffer))
          (recenter 'top))
        (message "Thank you for installing elhome!")
        )))
  
  (add-to-list 'load-path (el-get-subdir "el-get"))

  (if (require 'el-get nil t)
      (elhome-setup)
    (url-retrieve
     "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
     (lambda (s) 
       (end-of-buffer) 

       (let ((el-get-sources 
              '((:name el-get :compile nil))))
         (eval-print-last-sexp)
         (elhome-setup))))))
