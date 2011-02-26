;; A place to hang all your global, non-overridable keybindings.
;; Major modes will not generally be able to override these bindings
;; on you.  Thanks to Scott Frazer for this wonderful and simple hint
;; (http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs)
;; 
;; Loaded very early in the startup process because not having your
;; chosen keybindings in place can be such a pain when something goes
;; wrong!
(defvar me-minor-mode-map (make-keymap) "me-minor-mode keymap.")

;; (define-key me-minor-mode-map (kbd "C-i") 'some-function)

(define-minor-mode me-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " me" 'me-minor-mode-map)

(me-minor-mode 1)
