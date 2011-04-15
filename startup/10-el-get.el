(defun dwa/as-symbol (string-or-symbol)
  "If STRING-OR-SYMBOL is already a symbol, return it.  Otherwise
intern it and return that."
  (if (symbolp string-or-symbol) string-or-symbol
      (intern string-or-symbol)))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/el-get/"))

;; Keep track of which packages have been initialized
(defvar dwa/el-get-package-state
  (make-hash-table)
  "A hash mapping el-get package name symbols to their installation states")

(defun dwa/el-get-mark-initialized (package)
  (puthash (dwa/as-symbol package) 'init dwa/el-get-package-state))
(add-hook 'el-get-post-init-hooks 'dwa/el-get-mark-initialized)

;; Install el-get if necessary
(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
    (end-of-buffer)
    (eval-print-last-sexp)))

;; Install/init packages that I need in order to complete the init sequence
(let ((el-get-sources
      '((:name initsplit
             :type git
             :url "git://github.com/dabrahams/initsplit.git"
             :features (initsplit)
             ))))
  (el-get 'wait))

;;
;; generic one-shot event support
;;
(defvar dwa/event-tasks (make-hash-table :test 'equal)
  "A hash mapping event triggers to lists of functions to be called")

(defun dwa/event-occurred (event)
  (dolist (task (gethash event dwa/event-tasks))
    (ignore-errors (funcall task)))
  (remhash event dwa/event-tasks))

(defun dwa/add-event-task (event task)
  (puthash event (cons task (gethash event dwa/event-tasks)) dwa/event-tasks))

;;
;; fire an event for completion of el-get's init, install, and update phases
;;
(defun dwa/el-get-event-id (package action)
  (list (dwa/as-symbol package) (intern (format "el-get-%s" action))))

(defun dwa/el-get-event-occurred (package action)
  (dwa/event-occurred (dwa/el-get-event-id package action)))

(dolist (action '(init install update))
  (add-hook (intern (format "el-get-post-%s-hooks" action)) 
            `(lambda (p) (dwa/el-get-event-occurred p ',action))))

(defvar dwa/el-get-dependency-alist
    '((wanderlust . (apel flim semi))
      (semi . (flim apel))
      (flim . (apel))
      (auto-complete-clang . (auto-complete)))
  "An alist whose keys are symbols representing the names of
packages and whose values are lists of symbols representing
packages on which the key depends")

(defun dwa/el-get-dependencies (package)
  "Return the list of packages (as symbols) on which PACKAGE
depends"
  (let ((deps (cdr (assoc package dwa/el-get-dependency-alist))))
    ;; Make sure all elpa packages depend on the package `package'.
    ;; The package `package' is an elpa package, though, so exclude
    ;; it to avoid a circular dependency.
    (if (and (not (eq package 'package))
             (eq 'elpa
                 (plist-get 
                  (el-get-package-def (symbol-name package)) 
                  :type)))
        (cons 'package deps)
      deps)))

(defun dwa/el-get-package-initialized-p (package)
  (eq (gethash package dwa/el-get-package-state) 'init))

(defun dwa/el-get-demand1 (package)
  "Install, if necessary, and init the el-get package given by
PACKAGE, a symbol"
  (let ((p (symbol-name package)))
    (if (string= (el-get-package-status p) "installed")
        (el-get-init p)
      (el-get-install p))))

(defadvice el-get-error-unless-package-p 
  (around dwa/disable-stupid-check (package) activate compile preactivate)
  (let ((el-get-sources (append el-get-sources (list (intern package)))))
    ad-do-it))

(defun dwa/el-get-dependent-installed (package)
  "Install the given PACKAGE (a symbol) iff all its dependents
are now installed"
  (when (every 'dwa/el-get-package-initialized-p
               (dwa/el-get-dependencies package))
    (dwa/el-get-demand1 package)))

(defcustom dwa/el-get-standard-packages 
  '("elhome" "byte-code-cache" "el-get" "initsplit")
  "A list of package names that are part of your
standard package requirements.  These will be installed and/or
initialized automatically at startup, as required."
  :type '(repeat string))

;; Make sure any customizations are saved before exiting.  Should
;; eventually be replaced by the use of cus-edit+
(defun dwa/save-customizations-before-exit ()
  (condition-case err 
      (progn (customize-unsaved) nil)
    (error 
     (or (equal err '(error "No user options are set but unsaved"))
         (apply 'signal err)))))
(add-to-list 'kill-emacs-query-functions 'dwa/save-customizations-before-exit)

(defun dwa/el-get-demand (package)
  "Cause the named PACKAGE to be installed asynchronously, after
all of its dependencies (if any).

PACKAGE may be either a string or the corresponding symbol"
  (interactive (list (el-get-read-package-name "Install" t)))
  (let* ((p (dwa/as-symbol package))
         (pname (symbol-name p)))

    ;; Add the package to our list and make sure customize knows it
    (unless (member pname dwa/el-get-standard-packages)
      (add-to-list 'dwa/el-get-standard-packages pname)
      (put 'dwa/el-get-standard-packages
           'customized-value (list (custom-quote dwa/el-get-standard-packages))))

    ;; don't do anything if it's already installed or in progress
    (unless (gethash p dwa/el-get-package-state)

      ;; Remember that we're working on it
      (puthash p 'installing dwa/el-get-package-state)

      (let ((non-installed-dependencies
             (remove-if 'dwa/el-get-package-initialized-p
                        (dwa/el-get-dependencies p))))
        (dolist (dep non-installed-dependencies)
          (dwa/add-event-task 
           (dwa/el-get-event-id dep 'init)
           `(lambda () (dwa/el-get-mark-initialized ',dep)
              (dwa/el-get-dependent-installed ',p)))
          (dwa/el-get-demand dep))

        (unless non-installed-dependencies
          (dwa/el-get-demand1 p))))))

(dolist (p dwa/el-get-standard-packages)
  (dwa/el-get-demand p))
