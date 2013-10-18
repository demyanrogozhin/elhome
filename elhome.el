;;; elhome.el --- A framework for a "home" Emacs configuration

;; Description:
;; Everything you need to hang your emacs customizations off of,
;; install your own packages, etc., without the system becoming
;; unscalable


;; Install:
;; See README.markdown for details. You need to call (elhome-init),
;; which el-get can do for you, or you can load this file manually and
;; then call (elhome-init).

;; *** IMPORTANT NOTE ***: I would rather call this module ElHombre,
;; but can't find a good excuse.

;; Author: Dave Abrahams <dave@boostpro.com>
;; Created:  2010-11-02
;; Version: 0.9
;; Keywords: lisp
;; X-URL: http://github.com/dabrahams/elhome

;; This file is in the public domain

;;; History:

;;; Code:

(defgroup elhome nil
  "Modular elisp home configuration")

(defconst elhome-initial-load-path load-path 
  "The load path as it was before elhome modified it")

(defun elhome-path-join (&rest paths)
  "Assemble a filesystem path from path elements in HEAD and (optional) TAIL.
If TAIL contains a rooted path element, any preceding elements are discarded."
  (elhome-foldr
   (lambda (e path)
     (if path
         (if (file-name-absolute-p path) 
             path
           (concat (file-name-as-directory e) path))
       e))
   paths nil
   ))

(defun elhome-foldl (func seq &optional init)
  "A simple foldl function; avoids a dependency on CL."
  (if (null seq) init 
    (elhome-foldl func 
                   (cdr seq)
                   (funcall func init (car seq)))))

(defun elhome-foldr (func seq &optional init)
  "A simple foldr function; avoids a dependency on CL."
  (if (null seq) init 
    (funcall func (car seq)
             (elhome-foldr func (cdr seq) init) )))

(defconst elhome-installation-directory
  (cond ((boundp 'elhome-installation-directory)
         elhome-installation-directory)
        (load-file-name 
         (file-name-directory load-file-name))
        (t (elhome-path-join
            user-emacs-directory "el-get/elhome"))))
         
(defun elhome-load (lib &optional noerror nomessage nosuffix must-suffix)
  (when debug-on-error
    (message "elhome: loading %s" lib))
  (load lib noerror nomessage nosuffix must-suffix))

;; top-level function that does all the work.
;;;###autoload
(defun elhome-init ()
  "Prepare elhome for use.  Call this function early in your .emacs"
  (interactive)
  (unless (boundp 'elhome-directory)
    (defconst elhome-directory
      (file-name-as-directory
       (elhome-path-join user-emacs-directory "elhome")))
    "Directory name where a user's home configuration is stored.
Defaults to `~/.emacs.d/elhome/', unless you set it in your .emacs first"
    )

  (unless (boundp 'elhome-settings-directory)
    (defconst elhome-settings-directory
      (file-name-as-directory
       (elhome-path-join elhome-directory "settings")))
    "Directory name where customizations are stored.
Defaults to elhome-directory/`settings/', unless you set it in your .emacs first"
    )

  ;; Add to the load path the directory of any elisp below the
  ;; site-lisp/ subdirectory of elhome-directory, and the
  ;; elhome-settings-directory for convenience
  (setq load-path (append
                   (elhome-add-subdirs-containing 
                    (elhome-path-join elhome-directory "site-lisp")
                    elhome-load-suffix-regexp 
                    elhome-initial-load-path)
                   `(,elhome-settings-directory)
                   ))

  (setq custom-file (elhome-path-join elhome-settings-directory "settings.el"))

  (if (file-exists-p custom-file)
      (elhome-load (elhome-strip-lisp-suffix custom-file)))

  ;; load up all the startup files
  (mapc (lambda (file) (elhome-load file))
        (sort
         (apply 
          'append
          (mapcar (lambda (dir)
                    (elhome-directory-elisp
                     (elhome-path-join dir "startup")))
                  (list elhome-directory elhome-installation-directory)))
         (lambda (x y) 
           (string< (file-name-nondirectory x)
                    (file-name-nondirectory y))))))

(defun elhome-string-join (strings &optional sep)
  "Concatenate the given STRINGS, separated by SEP
If SEP is not supplied, it defaults to the empty string."
  (setq sep (or sep ""))
  (apply 'concat
         (elhome-foldr
          (lambda (s r) (cons s (and r (cons sep r))))
          strings)))
   
(defconst elhome-load-suffix-regexp
  (concat (mapconcat 'regexp-quote (get-load-suffixes) "\\|") "\\'"))

(defun elhome-unique (seq &optional pred)
  "Eliminate adjacent duplicates from SEQ.  PRED is used to
determine equality.  If PRED is not supplied, `equal' is used"
  (elhome-foldr 
   (lambda (e r) (if (and r (funcall (or pred 'equal) e (car r)))
                     r (cons e r)))
   seq))

(defun elhome-strip-lisp-suffix (path)
  (replace-regexp-in-string elhome-load-suffix-regexp "" path))

(defun elhome-nondirectory-elisp (directory)
  "Return a sorted list of all the elisp files in DIRECTORY, sans extension, without duplicates.
Thus, if DIRECTORY contains both foo.el and foo.elc, \"foo\" will appear once in the list"
  (mapcar 'file-name-nondirectory (elhome-directory-elisp directory)))

(defun elhome-directory-elisp (directory)
  "Return a sorted list of the full path to all the elisp files in DIRECTORY, sans extension, without duplicates.
Thus, if DIRECTORY contains both foo.el and foo.elc, \"foo\" will appear once in the list."
  (and (file-directory-p directory)
       (elhome-unique
        (mapcar
         'elhome-strip-lisp-suffix
         (directory-files directory t elhome-load-suffix-regexp)))))

(defun elhome-add-subdirs-containing (root pattern subdirs)
  "Prepend to SUBDIRS the directories including and below ROOT containing files whose names match PATTERN"
  (dolist (f (if (file-directory-p root) (directory-files root t) nil) subdirs)
    (if (file-directory-p f)
        (unless (member (file-relative-name f root) '("." ".."))
          (setq subdirs (elhome-add-subdirs-containing f pattern subdirs)))
      (if (string-match pattern f)
          (add-to-list 'subdirs (file-name-directory f))))))

(provide 'elhome)
;;; elhome.el ends here
