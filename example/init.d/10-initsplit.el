; initsplit-customizations-alist, which stores the identity of all the
; split customization files, is only available once we load initsplit.
(require 'initsplit)

;; Load up all the split customization files with the elhome settings
;; directory in the load path so initsplit-customizations-alist can
;; use simple paths.
(let ((load-path (cons elhome-settings-directory load-path)))
  (mapc 
   (lambda (init-file-spec)
     (load (elhome-strip-lisp-suffix (cadr init-file-spec)))
     )
   initsplit-customizations-alist))

(defadvice
  initsplit-split-user-init-file (around initsplit-in-elhome-settings-dir activate)
  "Make sure initsplit has the elhome settings directory set as the default when writing files"
  (let ((default-directory elhome-settings-directory))
    ad-do-it))

;; Make sure we byte-compile all customization files
(add-hook 'after-save-hook 
          ;; work around the bug that initsplit-byte-compile-files
          ;; doesn't itself require bytecomp
          (lambda () (require 'bytecomp) (initsplit-byte-compile-files)) 
          t)
