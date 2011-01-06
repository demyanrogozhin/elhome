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
        "https://github.com/dabrahams/el-get/raw/t/dev/el-get-install.el" ;; personal clone
        ;; "file:///Users/dave/Dropbox/home/.emacs.d/el-get/el-get/el-get-install.el" ;; local copy
        )

     ;; Evaluate it to install el-get
     (end-of-buffer)
     (eval-last-sexp nil)
     (kill-buffer))))

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

(defun dwa/el-get-package-initialized-p (package)
  (eq (gethash package dwa/el-get-package-state) 'init))

(defun dwa/el-get-force-install (package)
  "Install the el-get package given by PACKAGE, a symbol"
  (let ((el-get-sources (list package)))
    (el-get-install (symbol-name package))))

(defadvice el-get-error-unless-package-p 
  (around dwa/disable-stupid-check (package) activate compile preactivate)
  (let ((el-get-sources (append el-get-sources (list (intern package)))))
    ad-do-it))

(defun dwa/el-get-dependent-installed (package)
  "Install the given PACKAGE (a symbol) iff all its dependents
are now installed"
  (when (every 'dwa/el-get-package-initialized-p
               (cdr (assoc package dwa/el-get-dependency-alist)))
    (dwa/el-get-force-install package)))

(defun dwa/el-get-install (package)
  "Cause the named PACKAGE to be installed asynchronously, after
all of its dependencies (if any).

PACKAGE may be either a string or the corresponding symbol"
  (interactive (list (el-get-read-package-name "Install" t)))
  (let ((p (dwa/as-symbol package)))
    ;; don't do anything if it's already installed or in progress
    (unless (gethash package dwa/el-get-package-state)

      ;; Remember that we're working on it
      (puthash p 'installing dwa/el-get-package-state)

      (let ((non-installed-dependencies
             (remove-if 'dwa/el-get-package-initialized-p
                        (cdr (assoc p dwa/el-get-dependency-alist)))))
        (dolist (dep non-installed-dependencies)
          (dwa/add-event-task 
           (dwa/el-get-event-id dep 'init)
           `(lambda () (dwa/el-get-mark-initialized ',dep)
              (dwa/el-get-dependent-installed ',p)))
          (dwa/el-get-install dep))

        (unless non-installed-dependencies
          (dwa/el-get-force-install p))))))

(defvar dwa/my-packages
  '(notify
    wanderlust
    package
    wanderlust
    org-mode 
    auto-complete
    bbdb
    el-get
    emacs-w3m
    magit
    mailcrypt
    filladapt
    flex-mode
    auto-complete-clang))

(dolist (p dwa/my-packages)
  (dwa/el-get-install p))
