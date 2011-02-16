
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(gnus-buttonized-mime-types (quote ("multipart/signed" "multipart/alternative" "application/msword")))
 '(gnus-extra-headers (quote (To Newsgroups X-Spambayes-Classification Reply-To Message-ID Message-Id)))
 '(gnus-gravatar-style (quote inline))
 '(gnus-group-line-format "%M%S%p%P%5y%~(form my-align-gnus-group)@|%B%(%G%)%O
")
 '(gnus-ignored-from-addresses "^david.abrahams@rcn.com\\|dave@boost\\(-consulting\\|pro\\).com$")
 '(gnus-picon-style (quote right))
 '(gnus-registry-install t)
 '(gnus-secondary-select-methods (quote ((nnimap "Personal GMail" (nnimap-address "imap.gmail.com") (nnimap-server-port 993) (nnimap-stream ssl)))))
 '(gnus-select-method (quote (nnimap "BoostPro GMail" (nnimap-address "imap.gmail.com") (nnimap-stream ssl) (nnimap-authenticator login) (nnimap-nov-is-evil t))))
 '(gnus-summary-ignore-duplicates t)
 '(gnus-treat-fill-long-lines (quote first) nil nil "
Some people don't embed linebreaks in their paragraphs; this will force-add them.")
 '(gnus-treat-from-picon (quote head))
 '(gnus-treat-mail-picon (quote head))
 '(gnus-treat-newsgroups-picon (quote head)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
