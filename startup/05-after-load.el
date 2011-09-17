;; This file causes a file of the form elhome/etc/xxxx-settings.el[c]
;; to be automatically loaded after the xxxx library is loaded

(defcustom elhome-settings-file-regexp "\\`\\(.+\\)-settings\\'"
  "A regexp used to match (the non-extension part of) filenames
  in `elhome-settings-directory' that should be automatically
  loaded and used for customizations after a library is loaded.
  The first match group names the library after which to load and
  the prefix of all customization variables placed there."
  :type 'regexp
  :group 'elhome)

(defun elhome-file-loaded-p (file)
  (load-history-filename-element (load-history-regexp file)))

(defvar elhome-loading-settings '())

(defcustom elhome-reloaded-settings-libs nil
  "A list of library names whose corresponding \"-settings\"
files should be re-loaded each time the corresponding library is
loaded rather than only once.  You may want to put files in this
list that completely replace the definitions of existing library
functions, however note that any unsaved customizations stored in
the \"-settings\" file will be lost when the library is
reloaded."
  :type '(repeat string)
  :group 'elhome)

(defvar elhome-libs-with-settings nil
  "A cache that is either nil when outdated, or is a hash whose
keys are the names of libraries and whose values are
corresponding \"-settings\" files in
`elhome-settings-directory'.")

;; Each time Emacs goes idle for 5 seconds, throw out the settings
;; file cache.
(run-with-idle-timer 
 5 'repeat (lambda () (setq elhome-libs-with-settings nil)))

(defsubst elhome-libs-with-settings ()
  "Return a hash of library names having \"-settings\" files in
`elhome-settings-directory'."
  (or elhome-libs-with-settings (elhome-recompute-libs-with-settings)))

(defun elhome-recompute-libs-with-settings ()
  "Refresh and return the value of `elhome-libs-with-settings'."
  (setq elhome-libs-with-settings (make-hash-table :test 'equal))
  (dolist (f (elhome-nondirectory-elisp elhome-settings-directory))
    (when (string-match elhome-settings-file-regexp f)
      (puthash (match-string 1 f) f elhome-libs-with-settings)))
  elhome-libs-with-settings)

(defun elhome-do-load-settings (abs-file s lib)
  (setq s (concat
           (file-name-as-directory elhome-settings-directory) s))
      (when (and (not (member s elhome-loading-settings))
                 (or (not (elhome-file-loaded-p s))
                     (member lib elhome-reloaded-settings-libs)))
        (let ((elhome-loading-settings
               (cons s elhome-loading-settings)))
          (load s))))

(defun elhome-load-settings (abs-file)
  "Given ABS-FILE, the absolute filename of a library that has
been loaded, load its corresponding \"-settings\" file."
  (let* ((lib (file-name-nondirectory (elhome-strip-lisp-suffix abs-file)))
         (s (gethash lib (elhome-libs-with-settings))))
    (when s (elhome-do-load-settings abs-file s lib))))
(add-hook 'after-load-functions 'elhome-load-settings)

;; load -settings.el files for libs that were loaded before this lib
(mapc 'elhome-load-settings (delete "" (mapcar 'car load-history)))
