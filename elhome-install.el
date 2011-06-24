(let ((debug-on-error t))

  (defun el-get-subdir (&rest d)
    (mapconcat 'file-name-as-directory
               (append (list user-emacs-directory "el-get") d) ""))

  (setq el-get-byte-compile nil)
  (unless (require 'el-get nil t)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
      (end-of-buffer)
      (eval-print-last-sexp)))

  (switch-to-buffer "*Messages*")
  (message "*\n*\n* Patience please; ELHOME is installing...\n* \n*")
  (add-hook 'el-get-post-install-hooks 'el-get-init)

  (let ((el-get-sources
         '((:name elhome :depends (initsplit byte-code-cache)))))
    (el-get 'wait '(elhome)))

  (with-current-buffer
      (find-file-noselect
       (concat (el-get-subdir "elhome") "README.markdown"))
    (goto-char (point-max))
    (search-backward "## Congratulations")
    (switch-to-buffer (current-buffer))
    (recenter 'top))
  (message "Thank you for installing elhome!"))

