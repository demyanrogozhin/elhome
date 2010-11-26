;;; elhome --- A framework for a "home" Emacs configuration

;; Description:
;; Everything you need to hang your emacs customizations off of,
;; install your own packages, etc., without the system becoming
;; unscalable


;; Install:
;; You can use this file as your .emacs (or .emacs.d/init.el)
;; directly, or symlink to it. If you need to customize where things
;; are stored (see elhome-directory below for example) you can load it
;; from your .emacs after setting up some constants.

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

;; top-level function that does all the work.
(defun elhome-init ()
  (unless (boundp 'elhome-directory)
    (defconst elhome-directory
      (file-name-as-directory
       (elhome-path-join "~" ".emacs.d" "elhome")))
    "Directory name where a user's home configuration is stored.
Defaults to `~/.emacs.d/elhome/', unless you set it in your .emacs first"
    )

  ;; load up all the startup.d files
  (mapc 'load 
        (elhome-directory-elisp
         (elhome-path-join elhome-directory "startup.d")))
  )

(defun elhome-foldl (func seq init)
  "A simple foldl function; avoids a dependency on CL"
  (if (null seq) init 
    (elhome-foldl func 
                   (cdr seq)
                   (funcall func init (car seq)))))

(defun elhome-foldr (func seq init)
  "A simple foldr function; avoids a dependency on CL"
  (if (null seq) init 
    (funcall func (car seq)
             (elhome-foldr func (cdr seq) init) )))

(defun elhome-join (strings &optional sep)
  "Concatenate the given STRINGS, separated by SEP
If SEP is not supplied, it defaults to the empty string."
  (setq sep (or sep ""))
  (apply 'concat
         (elhome-foldr
          (lambda (s r) (cons s (and r (cons sep r))))
          strings nil )))
   
(defconst elhome-load-suffix-regexp
  (concat (elhome-join (mapcar 'regexp-quote (get-load-suffixes)) "\\|") "\\'"))

(defun elhome-unique (seq)
  "eliminate adjacent duplicates, as determined by equal, from seq"
  (elhome-foldr 
   (lambda (e r) (if (and r (equal e (car r)))
                     r (cons e r)))
   seq nil))

(defun elhome-directory-elisp (directory)
  "Return a list of all the elisp files in DIRECTORY, sans extension, without duplicates"
  (and (file-directory-p directory)
       (elhome-unique
        (mapcar
         (lambda (path)
           (replace-regexp-in-string elhome-load-suffix-regexp "" path))
         (directory-files directory t elhome-load-suffix-regexp)))))

(defun elhome-path-join (&rest paths)
  "Assemble a filesystem path from path elements in HEAD and (optional) TAIL.
If TAIL contains a rooted path element, any preceding elements are discarded"
  (elhome-foldr
   (lambda (e path)
     (if path
         (if (file-name-absolute-p path) 
             path
           (concat (file-name-as-directory e) path))
       e))
   paths nil
   ))
          
;; Do the work
(elhome-init)
(provide 'elhome)
