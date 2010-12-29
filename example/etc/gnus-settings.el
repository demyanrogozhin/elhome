
(custom-set-variables
 '(gnus-treat-newsgroups-picon (quote head))
 '(gnus-treat-mail-picon (quote head))
 '(gnus-treat-from-picon (quote head))
 '(gnus-treat-fill-long-lines (quote first) nil nil "
Some people don't embed linebreaks in their paragraphs; this will force-add them.")
 '(gnus-summary-ignore-duplicates t)
 '(gnus-select-method (quote (nnimap "BoostPro GMail" (nnimap-address "imap.gmail.com") (nnimap-stream ssl) (nnimap-authenticator login) (nnimap-nov-is-evil t))))
 '(gnus-secondary-select-methods (quote ((nnimap "Personal GMail" (nnimap-address "imap.gmail.com") (nnimap-server-port 993) (nnimap-stream ssl)))))
 '(gnus-registry-install t)
 '(gnus-picon-style (quote right))
 '(gnus-ignored-from-addresses "^david.abrahams@rcn.com\\|dave@boost\\(-consulting\\|pro\\).com$")
 '(gnus-group-line-format "%M%S%p%P%5y%~(form my-align-gnus-group)@|%B%(%G%)%O
")
 '(gnus-gravatar-style (quote inline))
 '(gnus-extra-headers (quote (To Newsgroups X-Spambayes-Classification Reply-To Message-ID Message-Id)))
 '(gnus-buttonized-mime-types (quote ("multipart/signed" "multipart/alternative" "application/msword"))))
(custom-set-faces)