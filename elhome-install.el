(let ((debug-on-error t))

  (defun el-get-subdir (&rest d)
    (mapconcat 'file-name-as-directory
               (append (list user-emacs-directory "el-get") d) ""))

  (unless (require 'el-get nil t)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
      (end-of-buffer)
      (eval-print-last-sexp)))

  (switch-to-buffer "*Messages*")
  (message "*\n*\n* Patience please; ELHOME is installing...\n* \n*")

  (message "Switching to dabrahams' el-get...")

  (let* ((default-directory (el-get-subdir "el-get"))
         (git (executable-find "git")))

    (unless (zerop (call-process git nil nil t 
                                 "remote" "add" "dabrahams"
                                 "https://github.com/dabrahams/el-get.git"))
      (error "unable to point origin at dabrahams' el-get"))
    (unless (zerop (call-process git nil nil t "fetch" "dabrahams"))
      (error "unable to fetch from dabrahams/el-get"))
    (unless (zerop (call-process git nil nil t "branch" "-m" "master" "dimitri-master"))
      (error "unable to rename local dimitri master"))
    (unless (zerop (call-process git nil nil t "checkout" "--track" "dabrahams/master"))
      (error "unable to checkout dabrahams' master"))
    )

  (add-to-list 'load-path (el-get-subdir "el-get"))

  ;; Reload el-get after switching to dwamacs
  (load-library "el-get")

  (let ((el-get-sources 
         '((:name initsplit :compile nil)
           byte-code-cache markdown-mode
           elhome)))
    (el-get 'sync))

  (with-current-buffer
      (find-file-noselect
       (concat (el-get-subdir "elhome") "README.markdown"))
    (goto-char (point-max))
    (search-backward "## Congratulations")
    (switch-to-buffer (current-buffer))
    (recenter 'top))

  (message "Thank you for installing elhome!"))
