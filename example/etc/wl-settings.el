(require 'signature)
(setq signature-insert-at-eof t)
(setq signature-delete-blank-lines-at-eof t)

(add-hook
 'wl-init-hook
 '(lambda ()
    ;; Add support for (signature . "filename")
    (unless (assq 'signature wl-draft-config-sub-func-alist)
      (wl-append wl-draft-config-sub-func-alist
                 '((signature . wl-draft-config-sub-signature))))

    (defun mime-edit-insert-signature (&optional arg)
      "Redefine to insert a signature file directly, not as a tag."
      (interactive "P")
      (insert-signature arg))

    ;; Keep track of recently used Email addresses
    (recent-addresses-mode 1)
    ))

(add-hook
 'wl-folder-mode-hook
 '(lambda ()
    (hl-line-mode t)
    ))

(defun wl-draft-config-sub-signature (content)
  "Insert the signature at the end of the MIME message."
  (let ((signature-insert-at-eof nil) ; believe it or not, having this
                                      ; set to t interferes with
                                      ; wl-draft putting the signature
                                      ; at the real end of the buffer.
        (signature-file-name content))
    (goto-char (mime-edit-content-end))
    (insert-signature)))


;; Settings
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(wl-ask-range nil nil nil "
The range thing slows me down.  However, I'd still like to know how to force the question.")
 '(wl-auto-check-folder-list (quote ("Inbox")))
 '(wl-auto-check-folder-name "Inbox")
 '(wl-auto-select-next (quote skip-no-unread))
 '(wl-auto-uncheck-folder-list (quote ("\\$.*" "%zz_mairix.*" "%zz_archive.*" "%.*")))
 '(wl-dispose-folder-alist (quote (("^-" . remove) ("^@" . remove) ("\\<All Mail\\>" . trash) ("^%" . remove))) nil nil "
Only disposing of something in \"All Mail\" should actually move it to
the trash (GMail will clean that up after 30 days).  Otherwise, we can
fully delete it from the current folder because we always have a copy
in \"All Mail.\"
")
 '(wl-draft-always-delete-myself t)
 '(wl-draft-config-alist (quote (("" (part-bottom . "
") ("Bcc" . "Dave Abrahams <dave@boostpro.com>") (signature . "~/.signature")))))
 '(wl-draft-reply-buffer-style (quote full))
 '(wl-draft-sendlog-max-size 100000 nil nil "
Keep more sent messages around for quick/easy access
")
 '(wl-draft-use-cache t nil nil "
This has to be on if I want the 'sendlog folder to contain anything
")
 '(wl-fldmgr-add-complete-with-current-folder-list t)
 '(wl-folder-desktop-name #("Messages" 0 8 (wl-folder-is-group is-group wl-folder-entity-id 0)))
 '(wl-folder-notify-deleted t)
 '(wl-folder-petname-alist (quote (("%INBOX" . "Inbox") ("+drafts" . "Drafts") (#("%[Gmail]/Sent" 0 13 (wl-folder-entity-id 3 wl-folder-is-group nil)) . "Sent") (#("%inbox:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 58 (wl-folder-entity-id 72 wl-folder-is-group nil)) . "Inbox") (#("%[Gmail]/Trash:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 66 (wl-folder-entity-id 74 wl-folder-is-group nil)) . "Trash") (#("%[Gmail]/Star:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 65 (wl-folder-entity-id 75 wl-folder-is-group nil)) . "With a Star") (#("%[Gmail]/Sent:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 65 (wl-folder-entity-id 76 wl-folder-is-group nil)) . "Sent") (#("%[Gmail]/Draft:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 66 (wl-folder-entity-id 77 wl-folder-is-group nil)) . "Draft") (#("%[Gmail]/All E-Mails:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 72 (wl-folder-entity-id 78 wl-folder-is-group nil)) . "All E-Mails") (#("%Org-Mode:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 61 (wl-folder-entity-id 79 wl-folder-is-group nil)) . "Org-Mode") (#("%[Gmail]/Draft" 0 14 (wl-folder-entity-id 4 wl-folder-is-group nil)) . "Drafts") (#("%[Gmail]/Star" 0 13 (wl-folder-entity-id 2 wl-folder-is-group nil)) . "Flagged") ("%Trash" . "Trash") (#("%INBOX" 0 6 (wl-folder-entity-id 1 wl-folder-is-group nil)) . "Inbox") (#("%[Gmail]/Starred" 0 16 (wl-folder-entity-id 2 wl-folder-is-group nil)) . "Important") (#("%[Gmail]/Sent Mail" 0 18 (wl-folder-entity-id 3 wl-folder-is-group nil)) . "Sent") (#("%[Gmail]/Drafts" 0 15 (wl-folder-entity-id 4 wl-folder-is-group nil)) . "Drafts") (#("%[Gmail]/All Mail" 0 17 (wl-folder-entity-id 5 wl-folder-is-group nil)) . "Archive") (#("%[Gmail]/Trash" 0 14 (wl-folder-entity-id 6 wl-folder-is-group nil)) . "Trash") (#("%[Gmail]/Spam" 0 13 (wl-folder-entity-id 8 wl-folder-is-group nil)) . "Spam") (#("+draft" 0 6 (wl-folder-entity-id 9 wl-folder-is-group nil)) . "Drafts"))))
 '(wl-folder-process-duplicates-alist (quote (("^.*" . hide))) nil nil "
Don't show me any duplicate messages")
 '(wl-folder-window-width 60)
 '(wl-highlight-folder-by-numbers 1)
 '(wl-icon-directory "~/.emacs.d/el-get/wanderlust/icons/")
 '(wl-interactive-exit nil)
 '(wl-interactive-save-folders nil)
 '(wl-interactive-send nil)
 '(wl-message-ignored-field-list (quote ("^.*:")))
 '(wl-message-sort-field-list (quote ("^From" "^Organization:" "^X-Attribution:" "^Subject" "^Date" "^To" "^Cc")))
 '(wl-message-visible-field-list (quote ("^\\(To\\|Cc\\):" "^Subject:" "^\\(From\\|Reply-To\\):" "^Organization:" "^Message-Id:" "^\\(Posted\\|Date\\):" "^\\(Mailer\\|User-Agent\\):" "^\\(List-Post\\):" "^\\(Xref\\):")))
 '(wl-smtp-authenticate-type "plain")
 '(wl-smtp-connection-type (quote starttls))
 '(wl-smtp-posting-port nil)
 '(wl-smtp-posting-server "smtp.gmail.com")
 '(wl-smtp-posting-user "dave@boostpro.com")
 '(wl-spam-folder "%[Gmail]/Spam")
 '(wl-summary-auto-sync-marks nil nil nil "
Trying this setting to see if it improves usability vastly and if I
can tolerate being out-of-sync occasionally.")
 '(wl-summary-line-format "%T%P%M/%D(%W)%h:%m %[ %17f %]%[%1@%] %t%C%s")
 '(wl-summary-showto-folder-regexp "^%" nil nil "Show recipient in place of sender in IMAP folders when I'm the sender")
 '(wl-summary-width nil)
 '(wl-thread-insert-opened t)
 '(wl-trash-folder "%Trash" nil nil "
wl-dispose-folder-alist is set up so the only messages sent to Trash
have been marked disposed in an \"All Mail\" folder.  Any others should
be deleted immediately since there is a copy in All Mail.
")
 '(wl-use-folder-petname (quote (modeline ask-folder read-folder)) nil nil "
I have some hard-to-type folder names; why struggle?
")
 '(wl-user-mail-address-list (quote ("dave@boostpro.com" "dave.abrahams@gmail.com" "daveabrahams@gmail.com" "boost.consulting@gmail.com" "david.abrahams@rcn.com" "dave@luannocracy.com"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
