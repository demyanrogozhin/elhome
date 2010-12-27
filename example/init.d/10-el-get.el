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
     (with-current-buffer
         (url-retrieve-synchronously 
         ;; "https://github.com/dimitri/el-get/raw/master/el-get-install.el" ;; official repo
         "https://github.com/dabrahams/el-get/raw/t/dev/el-get-install.el") ;; personal clone

       ;; Evaluate it to install el-get
       (end-of-buffer)
       (eval-last-sexp nil))

;;     (message "Waiting for el-get installation to complete...")
;;     (while (not (featurep 'el-get)) (sleep-for 0 100))
     (setq el-get-newly-installed t)))

  ;; My personal recipes are in my personal clone
  ;; (add-to-list 'el-get-recipe-path "~/.emacs.d/elhome/el-get-recipes")
    
  ;; List the packages I need
  (setq el-get-sources
        '(package
          org-mode 
          apel 
          auto-complete
          bbdb
          el-get
          emacs-w3m
          flim
          magit
          mailcrypt
          semi
          wanderlust
          filladapt
          flex-mode
          auto-complete-clang

          (:name initsplit
                 :type http
                 :url "https://github.com/dabrahams/elisp/raw/master/elisp/package.d/initsplit.el"
                 :features (initsplit)
;                 :after (lambda () (add-hook 'after-save-hook 'initsplit-byte-compile-files t))
                 )
          ))

  ;; If this is the first run, run el-get synchronously, to make sure
  ;; we don't miss anything important
  (if (or t el-get-newly-installed)
      (progn (switch-to-buffer "*Messages*")
             (delete-other-windows)
             (end-of-buffer)
             (el-get 'wait) )
    (el-get)))

(provide 'dwa/packages)

;; Others
               ;; color-theme
               ;; markdown-mode
               ;; worklog
