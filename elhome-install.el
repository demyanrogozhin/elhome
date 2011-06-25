(let ((debug-on-error t))

  (switch-to-buffer "*Messages*")
  (message "*\n*\n* Patience please; ELHOME is installing...\n* \n*")

  (setq el-get-byte-compile nil)
  (unless (require 'el-get nil t)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
      (end-of-buffer)
      (eval-print-last-sexp)))

  (switch-to-buffer "*Messages*")

  (add-hook 'el-get-post-install-hooks 'el-get-init)

  (eval-after-load 'elhome
    '(with-current-buffer
        (find-file-noselect
         (concat (el-get-package-directory "elhome") "README.markdown"))
       (elhome-init)
       (goto-char (point-max))
       (search-backward "## Congratulations")
       (switch-to-buffer (current-buffer))
       (recenter 'top)))

  (let ((el-get-sources
         '((:name elhome
            :depends (initsplit byte-code-cache)))))

    (el-get nil '(elhome)))

  (message "Thank you for installing elhome!"))