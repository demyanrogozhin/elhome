;; This file causes all customizations whose name begins with xxxx- to
;; be stored in xxxx-settings.el, if such a file exists.

(require 'initsplit)

(defadvice custom-save-all (around elhome-auto-initsplit
                                   activate compile preactivate)
  "Wrapper over custom-save-all that treats the files in
`elhome-settings-directory' as initsplit customization files.  

A file with the name \"foobar-settings.el\" will store all the
customizations whose name begins with \"foobar-\".  Note: depends
on initsplit!"
  (let* ((settings-files 
          (remove-if-not
           (lambda (s) (and
                        (string-match-p elhome-settings-file-regexp s)
                        (elhome-file-loaded-p (concat elhome-settings-directory s))))
           
           (mapcar 'file-name-nondirectory 
                   (elhome-directory-elisp elhome-settings-directory))))

         ;; sort by decreasing length allows org-settings.el and
         ;; org-attach-settings.el to coexist peacefully --- the
         ;; longer (thus more-specific) match will be made first
         (sorted-files (sort settings-files
                             (lambda (x y) (> (length x) (length y)))))

         ;; Add elements to the effective customizations alist used by
         ;; the advice `initsplit-custom-save-all'.
         (initsplit-dynamic-customizations-alist
          (mapcar (lambda (f) 
                    `(,(progn (string-match elhome-settings-file-regexp f)
                              (concat "^" (match-string 1 f)))
                      ,(concat elhome-settings-directory f) nil nil))
                  sorted-files)))

    ad-do-it))

