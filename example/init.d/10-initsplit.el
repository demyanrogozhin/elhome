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

;; Load up any customization themes based on the system-type and the
;; system-name.  This allows us to use the customize interface (via
;; customize-create-theme) to set up platform- and system- dependent
;; customizations.  To create a set of customizations that applies
;; when (eq system-type 'darwin), just create a theme called
;; "system-type-darwin".  See
;; [[info:emacs:Custom%20Themes][info:emacs:Custom Themes]] for mre on
;; themes.
(dolist (x '(type name))
  (let* ((var-name (concat "system-" (symbol-name x))) 
         (var-value (eval (intern var-name)))
         (theme (intern (concat var-name "-" (format "%s" var-value)))))
    (ignore-errors (load-theme theme))))
