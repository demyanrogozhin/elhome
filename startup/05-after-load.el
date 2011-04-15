;; This file causes a file of the form elhome/etc/xxxx-settings.el[c]
;; to be automatically loaded after the xxxx library is loaded

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

(defvar elhome-loading-settings '())

(defcustom elhome-reloaded-settings-prefixes nil
  "A list of prefix strings indicating \"-settings\" files that
should be re-loaded each time the corresponding library is loaded
rather than only once.  You may want to put files in this list
that completely replace the definitions of existing library
functions, however note that any unsaved customizations stored in
the settings file will be lost."
  :type '(repeat string)
  :group 'elhome)

(defun elhome-load-settings (abs-file)
  (let* ((key           (file-name-nondirectory (elhome-strip-lisp-suffix abs-file)))
         (settings      (concat elhome-settings-directory key "-settings"))
         (settings-file (condition-case nil (find-library-name settings) (error nil))))

    (when (and settings-file
               (not (member settings-file elhome-loading-settings))
               (or (member key elhome-reloaded-settings-prefixes)
                   (not (elhome-file-loaded-p settings-file))))
      (let ((elhome-loading-settings (cons settings-file elhome-loading-settings)))
        (load settings-file)))))

(add-hook 'after-load-functions 'elhome-load-settings)

;; load -settings.el files for libs that were loaded before this lib
(mapc 'elhome-load-settings (delete "" (mapcar 'car load-history)))
