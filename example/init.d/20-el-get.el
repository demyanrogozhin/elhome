(add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/el-get/"))

(let ((el-get-newly-installed))
  (condition-case nil 
      (require 'el-get)
    (file-error
     ;;
     ;; if el-get couldn't be found, try to install it from GitHub
     ;;
     (require 'bytecomp)

     ;; Find the installer page
     (save-excursion
       (set-buffer 
        ;; (url-retrieve-synchronously "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
        (url-retrieve-synchronously "https://github.com/dabrahams/el-get/raw/master/el-get-install.el")
        )

       ;; Evaluate it to install el-get
       (end-of-buffer)
       (eval-last-sexp nil))
     (message "Waiting for el-get installation to complete...")
     (while (not (featurep 'el-get)) (sleep-for 0 100))
     (setq el-get-newly-installed t)))

  ;; My personal recipes are in my personal clone
  ;; (add-to-list 'el-get-recipe-path "~/.emacs.d/elhome/el-get-recipes")
    
  ;; List the packages I need
  (setq el-get-sources
        '(org-mode apel auto-complete bbdb el-get emacs-w3m flim magit mailcrypt semi wl))

  ;; If this is the first run, run el-get synchronously, to make sure
  ;; we don't miss anything important
  (if (or t el-get-newly-installed) (el-get 'sync) (el-get)))

(provide 'dwa/packages)

;; Others
               ;; color-theme
               ;; mailcrypt
               ;; markdown-mode
               ;; org-mode
               ;; worklog
