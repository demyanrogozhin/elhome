;; This file causes a file of the form elhome/etc/xxxx-settings.el[c]
;; to be automatically loaded after the xxxx library is loaded, and
;; for all customizations whose name begins with xxxx- to be stored in
;; that file.
(require 'initsplit)

(defcustom elhome-settings-file-regexp "\\`\\(.+\\)-settings\\'"
  "A regexp used to match files in `elhome-settings-directory'
  that should be automatically loaded and used for customizations
  after a library is loaded.  The first match group names the
  library after which to load and the prefix of all customization
  variables placed there."
  :type 'regexp
  :group 'elhome)

(defun elhome-file-loaded-p (file)
  (load-history-filename-element (load-history-regexp file)))

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

(defcustom elhome-reloaded-settings-prefixes nil
  "A list of prefix strings indicating \"-settings\" files that
should be re-loaded each time the corresponding library is loaded
rather than only once.  You may want to put files in this list
that completely replace the definitions of existing library
functions, however note that any unsaved customizations stored in
the settings file will be lost."
  :type '(repeat 'string)
  :group 'elhome)

(defun elhome-load-settings (abs-file)
  (let* ((key           (file-name-nondirectory (elhome-strip-lisp-suffix abs-file)))
         (settings      (concat elhome-settings-directory key "-settings"))
         (settings-file (condition-case nil (find-library-name settings) (error nil))))

    (when (and settings-file
               (or (member key elhome-reloaded-settings-prefixes)
                   (not (elhome-file-loaded-p settings-file))))
      (load settings-file))))

(add-hook 'after-load-functions 'elhome-load-settings)

;; load -settings.el files for libs that were loaded before this lib
(mapc 'elhome-load-settings (mapcar 'car load-history))