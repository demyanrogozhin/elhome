(require 'initsplit)
(setq initsplit-default-directory elhome-settings-directory)


;; Ease-of-use feature
;;
;; If initsplit would load xxx-settings as a way of ensuring its
;; customizations aren't clobbered, try to load xxx instead (which
;; will trigger the loading of xxx-settings anyway).  Because it is
;; normal for xxx to be loaded before xxx-settings, the other order is
;; often untested, and only discovered at customization time.
;; Although the file can usually be fixed by adding a simple `(require
;; 'xxx)', the following usually avoids the error in the first place.  Note,
;; however, that if xxx-settings uses symbols from elsewhere,
;; e.g. xxx-yyy, it will still need to load or require that library.
(defun elhome-initsplit-load (file)
  "Causes FILE to be loaded.  If FILE is an xxx-settings file in
`elhome-settings-directory', first loads the `xxx' library if possible"
  (unless
      (and
       ;; Is this file in the right directory?
       (string= (file-name-directory file)
                (expand-file-name
                 (file-name-as-directory elhome-settings-directory)))
       ;; Does it exist?
       (ignore-errors (find-library-name file) t)

       (let* ((f (file-name-nondirectory file))
              (lib (when (string-match elhome-settings-file-regexp f)
                     (match-string 1 f))))
         ;; if it's an xxx-settings file, try to load xxx
         (ignore-errors (load-library lib) t)))
    ;; otherwise, fall back to the default initsplit behavior
    (initsplit-load-if-exists file)))
(setq initsplit-load-function 'elhome-initsplit-load)

;; Load up any customization themes based on the system-type and the
;; system-name.  This allows us to use the customize interface (via
;; customize-create-theme) to set up platform- and system- dependent
;; customizations.  To create a set of customizations that applies
;; when (eq system-type 'darwin), just create a theme called
;; "system-type-darwin".  See
;; [[info:emacs:Custom%20Themes][info:emacs:Custom Themes]] for more on
;; themes.
(dolist (x '(type name))
  (let* ((var-name (concat "system-" (symbol-name x)))
         (var-value (eval (intern var-name)))
         (theme-name (concat var-name "-" (format "%s" var-value)))
         (theme (intern theme-name))
         (ignored-errors
          `((file-error ("Cannot open load file" ,(concat theme-name "-theme")))
            (error ,(concat "Undefined Custom theme " theme-name))
            (error ,(concat "Unable to find theme file for `" theme-name "'"))
            ))
         (load-path (cons elhome-settings-directory load-path)))

    ;; Try to enable the theme
    (condition-case err
        (let ((custom-known-themes (list theme 'user)))
          (load-theme theme)
          (enable-theme theme))

      ((error file-error) 
       (unless (member err ignored-errors)
         (signal (car err) (cdr err)))))

    ;; HACK: remove the theme from the customization variable.  This
    ;; should stay programmatic.
    (setq custom-enabled-themes
          (delq theme custom-enabled-themes))))
