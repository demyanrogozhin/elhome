(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ac-clang-flags (quote ("-I" "/Users/dave/src/boost-svn-git" "-I" "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7/")))
 '(ac-dictionary-directories (quote ("~/.emacs.d/elhome/ac-dict/")))
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(blink-cursor-mode nil nil nil "
Blinking cursor just annoys me")
 '(c-default-style (quote ((java-mode . "java") (awk-mode . "awk") (other . "bsd"))))
 '(canlock-password "963afd5a40a33c7f59217100af5a7c1648af74a1")
 '(clang-flags (quote ("-I" "/Users/dave/src/boost-svn-git" "-I" "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7/")))
 '(cursor-type (quote box) t)
 '(default-frame-alist (quote ((font . "Monaco-15"))) nil nil "
On Linux this is really just a way of hanging onto and documenting my
settings for for default-frame-alist

  '(default-frame-alist (quote ((menu-bar-lines . 1) (font-backend . \"xft\") (font . \"Bitstream Vera Sans Mono-10.5\"))) nil nil \"

which currently aren't needed
since I have an .Xdefaults file containing:

  Emacs.FontBackend: xft
  Emacs.font: Bitstream Vera Sans Mono-10.5
  Emacs.toolBar: 0
  Emacs.menuBar: 1

Doing it in .Xdefaults prevents the initial window from flashing
and resizing.

Note that, on ubuntu at least, one must do 

  xrdb -merge ~/.Xdefaults

to get the changes to take effect

Despite what the customize interface says, menu-bar-lines and 
tool-bar-lines are set to 1 as part of the default value.  
However, customizing tool-bar-mode to nil sets tool-bar-lines
to zero here.

According to <http://article.gmane.org/gmane.emacs.devel/99324>, 
we need to explicitly set the font-backend to XFT or we won't 
get antialiasing.  

Had to evaluate (x-select-font) to find out the name of the
font that emacs would recognize.
")
 '(delete-selection-mode t nil nil "
Creates normal editor behavior: select a region and begin
typing, the region is replaced")
 '(diff-default-read-only t nil nil "
If you don't do this, all the nice navigation stuff is disabled by default.  Who wants to edit diffs by hand, anyway?")
 '(diff-jump-to-old-file t)
 '(diff-switches "-du")
 '(dired-listing-switches "-alh" nil nil "
Added -h so I can read file sizes")
 '(ediff-custom-diff-options "-u" nil nil "
Show me unified diffs by default")
 '(ediff-highlight-all-diffs nil nil nil "
only highlight the selected diff (keeps down gray cruft onscreen)")
 '(ediff-keep-variants t nil nil "
Any unchanged buffers in the ediff are removed when the session ends. 
`C-u q' to override when quitting.")
 '(ediff-merge-filename-prefix "")
 '(ediff-skip-merge-regions-that-differ-from-default nil)
 '(ediff-split-window-function (quote split-window-horizontally) nil nil "
Show diffs side-by-side")
 '(ediff-window-setup-function (quote ediff-setup-windows-plain) nil nil "
Run Ediff all in one frame.  The default when there's a window manager is for
emacs to pop up a separate frame for the `*Ediff Control Panel*' buffer")
 '(elmo-imap4-default-authenticate-type (quote clear))
 '(elmo-imap4-default-port 993)
 '(elmo-imap4-default-server "imap.gmail.com")
 '(elmo-imap4-default-stream-type (quote ssl))
 '(elmo-imap4-default-user "dave@boostpro.com")
 '(elmo-lang "en")
 '(elmo-localdir-folder-path "~/Maildir")
 '(elmo-message-fetch-confirm nil)
 '(elmo-message-fetch-threshold 250000 nil nil "
The default limit is so low that it always asks about messages that would fetch quickly.")
 '(elmo-nntp-default-server "news.gmane.org")
 '(elmo-search-namazu-default-index-path "~/Maildir")
 '(elmo-spam-scheme (quote bogofilter))
 '(erc-default-sound "~/erc.wav")
 '(erc-modules (quote (autoaway autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands readonly ring smiley sound stamp track)))
 '(erc-nick "bewst")
 '(erc-notify-mode t)
 '(erc-sound-mode t)
 '(explicit-bash-args (quote ("--noediting" "-i" "-l")) nil nil "
added -l so it would take things out of my .bash_profile, like (on boostpro.com) the prompt pattern.  Otherwise I get this abomination: ///bd5882fff11dd5c2900e1ce95b895e66")
 '(explicit-shell-file-name "bash" nil nil "
Giving an explicit path like /bin/bash (the default from my Linux boxen) fails on FreeBSD where the file doesn't live there.")
 '(ffap-machine-p-known (quote reject) nil nil "
This hung emacs on my Mac once when pinging.")
 '(ffap-require-prefix t nil nil "
Invoking ffap without any prefix tends to do things I don't intend.")
 '(g-user-email "dave@boostpro.com")
 '(gdb-max-frames 100 nil nil "
Increased the number of stack frames displayed from 40")
 '(global-auto-revert-mode t nil nil "
We want our file buffers to stay up-to-date with changes on disk")
 '(gravatar-icon-size 50)
 '(gravatar-retrieval-program "wget -q -O '%s' '%s'" nil nil "
Requires wget, which isn't on the Mac by default.  Someday should
figure out how to use curl instead, but for now I just installed wget
from macports.")
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-url-at-point t)
 '(imap-shell-program (quote ("dovecot --exec-mail imap")))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initsplit-customizations-alist (quote (("\\`gnus-" "gnus-customize.el" t) ("\\`\\(org\\|calendar\\|diary\\)-" "org-customize.el" t))))
 '(ispell-program-name "aspell")
 '(magit-git-executable "/opt/local/bin/git")
 '(magit-repo-dirs (quote ("/Users/dave/src" "/Users/dave/work/pipsync")))
 '(magit-repo-dirs-depth 1)
 '(mail-signature t)
 '(mail-user-agent (quote gnus-user-agent) nil nil "
Gnus Message with full Gnus features")
 '(mairix-command "ssh boostpro.com mairix")
 '(mairix-file-path "/home/dave/Maildir/")
 '(mairix-mail-program (quote wl))
 '(mairix-search-file ".zz_mairix-results")
 '(markdown-command "markdown-extra")
 '(message-citation-line-function (quote my-message-insert-citation-line) nil nil "
Make sure peoples' email addresses are (trivially) obscured")
 '(message-cite-prefix-regexp "\\([ 	]*[_.[:word:]]+>+\\|[ 	]*[]>|]\\)+" nil nil "
Removed \"}\" from the allowable characters because I often type that when writing replies.")
 '(message-default-headers "Bcc: dave@boostpro.com
" nil nil "
Always Bcc: myself")
 '(message-forward-ignored-headers (quote ("^Content-Transfer-Encoding:" "^X-Gnus" "^X-" "^Received:" "^User-Agent:" "^References:")))
 '(message-mode-hook (quote ((lambda nil (auto-fill-mode t)))) nil nil "
Automatically wrap text during email composition")
 '(message-send-mail-function (quote message-send-mail-with-sendmail))
 '(message-subject-re-regexp "^[ 	]*\\(\\([Rr][Ee]\\|[Aa][Ww]\\)\\(\\[[0-9]*\\]\\)*:[ 	]*\\)*[ 	]*" nil nil "
Handle Germans' Aw: version of Re:")
 '(message-subject-trailing-was-query t nil nil "
always strip the trailing old subject in (was: ...) subjects")
 '(message-syntax-checks (quote ((sender . disabled) (long-lines . disabled))) nil nil "
Don't complain about long lines, please")
 '(mime-edit-split-message nil nil nil "
This should really be the default.  Most MUAs can't decode the split messages!")
 '(mime-play-delete-file-immediately nil)
 '(mime-save-directory "/tmp")
 '(mm-attachment-override-types (quote ("text/x-vcard" "application/pkcs7-mime" "application/x-pkcs7-mime" "application/pkcs7-signature" "application/x-pkcs7-signature" "image/*")) nil nil "
Added image/* to display attached images inline")
 '(mm-discouraged-alternatives (quote ("text/html" "text/richtext" "image/.*")) nil nil "
The documentation for this variable says it all")
 '(mm-inline-text-html-with-images t)
 '(muse-project-alist (quote (("WikiPlanner" ("~/plans" :default "index" :major-mode planner-mode :visit-link planner-visit-link)))))
 '(ns-alternate-modifier (quote control) nil nil "
I'm continually pressing option when I mean control.  So, I get no
Command key.  Oh, well!  I wish I could make right-command work as
command.")
 '(ns-command-modifier (quote meta))
 '(ps-font-family (quote Helvetica))
 '(ps-font-info-database (quote ((Courier (fonts (normal . "Courier") (bold . "Courier-Bold") (italic . "Courier-Oblique") (bold-italic . "Courier-BoldOblique")) (size . 10.0) (line-height . 10.55) (space-width . 6.0) (avg-char-width . 6.0)) (Helvetica (fonts (normal . "Helvetica") (bold . "Helvetica-Bold") (italic . "Helvetica-Oblique") (bold-italic . "Helvetica-BoldOblique")) (size . 10.0) (line-height . 11.56) (space-width . 2.78) (avg-char-width . 5.09243)) (Times (fonts (normal . "Times-Roman") (bold . "Times-Bold") (italic . "Times-Italic") (bold-italic . "Times-BoldItalic")) (size . 10.0) (line-height . 11.0) (space-width . 2.5) (avg-char-width . 4.71432)) (Palatino (fonts (normal . "Palatino-Roman") (bold . "Palatino-Bold") (italic . "Palatino-Italic") (bold-italic . "Palatino-BoldItalic")) (size . 10.0) (line-height . 12.1) (space-width . 2.5) (avg-char-width . 5.08676)) (Helvetica-Narrow (fonts (normal . "Helvetica-Narrow") (bold . "Helvetica-Narrow-Bold") (italic . "Helvetica-Narrow-Oblique") (bold-italic . "Helvetica-Narrow-BoldOblique")) (size . 10.0) (line-height . 11.56) (space-width . 2.2796) (avg-char-width . 4.17579)) (NewCenturySchlbk (fonts (normal . "NewCenturySchlbk-Roman") (bold . "NewCenturySchlbk-Bold") (italic . "NewCenturySchlbk-Italic") (bold-italic . "NewCenturySchlbk-BoldItalic")) (size . 10.0) (line-height . 12.15) (space-width . 2.78) (avg-char-width . 5.31162)) (AvantGarde-Book (fonts (normal . "AvantGarde-Book") (italic . "AvantGarde-BookOblique")) (size . 10.0) (line-height . 11.77) (space-width . 2.77) (avg-char-width . 5.45189)) (AvantGarde-Demi (fonts (normal . "AvantGarde-Demi") (italic . "AvantGarde-DemiOblique")) (size . 10.0) (line-height . 12.72) (space-width . 2.8) (avg-char-width . 5.51351)) (Bookman-Demi (fonts (normal . "Bookman-Demi") (italic . "Bookman-DemiItalic")) (size . 10.0) (line-height . 11.77) (space-width . 3.4) (avg-char-width . 6.05946)) (Bookman-Light (fonts (normal . "Bookman-Light") (italic . "Bookman-LightItalic")) (size . 10.0) (line-height . 11.79) (space-width . 3.2) (avg-char-width . 5.67027)) (Symbol (fonts (normal . "Symbol")) (size . 10.0) (line-height . 13.03) (space-width . 2.5) (avg-char-width . 3.24324)) (Zapf-Dingbats (fonts (normal . "Zapf-Dingbats")) (size . 10.0) (line-height . 9.63) (space-width . 2.78) (avg-char-width . 2.78)) (ZapfChancery-MediumItalic (fonts (normal . "ZapfChancery-MediumItalic")) (size . 10.0) (line-height . 11.45) (space-width . 2.2) (avg-char-width . 4.10811)) (Zapf-Chancery-MediumItalic (fonts (normal . "ZapfChancery-MediumItalic")) (size . 10.0) (line-height . 11.45) (space-width . 2.2) (avg-char-width . 4.10811)))))
 '(python-python-command "/opt/local/bin/python")
 '(remember-annotation-functions (quote (org-remember-annotation)) nil nil "
As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html.  Note: buffer-file-name was checked in the default.")
 '(remember-handler-functions (quote (org-remember-handler)) nil nil "As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html.  Note: remember-append-to-file is checked in the default.")
 '(rmail-dont-reply-to-names "dave@\\(boost-consulting\\|boostpro\\)\\.com\\|dave\\.abrahams@rcn\\.com\\|boost\\.consulting@gmail\\.com\\|dave\\.boostpro@gmail\\.com\\|Undisclosed-recipients[:;]*")
 '(safe-local-variable-values (quote ((test-case-name . buildbot\.test\.test_sourcestamp) (test-case-name . buildbot\.test\.test_changes) (test-case-name . buildbot\.broken_test\.test_web_status_json) (encoding . utf8) (folded-file . t))))
 '(server-mode t nil nil "
Always run a server so we can open files in existing emacs frames.")
 '(show-paren-mode t)
 '(smtpmail-default-smtp-server "www.boostpro.com")
 '(smtpmail-local-domain "boostpro.com")
 '(smtpmail-smtp-service 587)
 '(smtpmail-starttls-credentials (quote (("www.boostpro.com" 587 "" ""))))
 '(split-height-threshold nil)
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
 '(tool-bar-mode nil nil nil "
Tool bars take up valuable screen real-estate for icons whose meaning I forget")
 '(tramp-backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(tramp-default-host "localhost")
 '(tramp-default-proxies-alist (quote (("\\`localhost\\'" nil nil) ("\\`206.217.198.21\\'" nil nil) ("\\`.+\\'" "\\`root\\'" "/ssh:%h:"))) nil nil "
Gets around the common setting that prohibits ssh login as root.

Don't do any proxying for connections to localhost (depends
on the customization of tramp-default-host to \"localhost\" for simple
matching), and otherwise, if sudo'ing somewhere, ssh there first and
then sudo on the remote host itself.")
 '(tramp-remote-path (quote (tramp-default-remote-path "/usr/sbin" "/usr/local/sbin" "/usr/local/bin" "/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin")))
 '(truncate-partial-width-windows nil)
 '(user-mail-address "dave@boostpro.com")
 '(vc-diff-switches "-du")
 '(w3m-confirm-leaving-secure-page t nil nil "
I never like being nannied by regular browsers either.")
 '(w3m-default-display-inline-images t)
 '(w3m-display-ins-del nil)
 '(w3m-use-cookies t)
 '(warning-suppress-types (quote ((\(undo\ discard-info\)))) nil nil "
Without this, emacs pops up annoying warnings in, e.g., *shell* buffers
where I don't expect it to be keeping undo history anyway")
 '(weblogger-config-alist (quote (("homepage" "http://daveabrahams.com/xmlrpc.php" "dave" "" "2") ("techarcana" "http://techarcana.net/xmlrpc.php" "dave" "" "1") ("cpp-next" "http://cpp-next.com/xmlrpc.php" "dave" "" "1") ("ryppl" "http://ryppl.org/xmlrpc.php" "dave" "" "4") ("boostpro" "http://boostpro.com/xmlrpc.php" "dave" "" "1"))))
 '(weblogger-edit-entry-hook (quote ((lambda nil (switch-to-buffer "*weblogger-entry*")))))
 '(weblogger-edit-mode (quote my-weblogger-markdown-mode))
 '(weblogger-server-url "http://cpp-next.com/xmlrpc.php")
 '(weblogger-server-username "dave")
 '(weblogger-start-edit-entry-hook (quote ((lambda nil (message-goto-body) (while (search-forward "
" nil t) (replace-match "" nil t))))))
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
 '(wl-folder-petname-alist (quote (("%INBOX" . "Inbox") ("+drafts" . "Drafts") (#("%[Gmail]/Sent" 0 13 (wl-folder-entity-id 3 wl-folder-is-group nil)) . "Sent") (#("%inbox:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 58 (wl-folder-entity-id 72 wl-folder-is-group nil)) . "Inbox") (#("%[Gmail]/Trash:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 66 (wl-folder-entity-id 74 wl-folder-is-group nil)) . "Trash") (#("%[Gmail]/Star:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 65 (wl-folder-entity-id 75 wl-folder-is-group nil)) . "With a Star") (#("%[Gmail]/Sent:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 65 (wl-folder-entity-id 76 wl-folder-is-group nil)) . "Sent") (#("%[Gmail]/Draft:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 66 (wl-folder-entity-id 77 wl-folder-is-group nil)) . "Draft") (#("%[Gmail]/All E-Mails:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 72 (wl-folder-entity-id 78 wl-folder-is-group nil)) . "All E-Mails") (#("%Org-Mode:\"dave.abrahams@gmail.com\"/clear@imap.gmail.com:993!" 0 61 (wl-folder-entity-id 79 wl-folder-is-group nil)) . "Org-Mode") (#("%[Gmail]/Draft" 0 14 (wl-folder-entity-id 4 wl-folder-is-group nil)) . "Drafts") (#("%[Gmail]/Star" 0 13 (wl-folder-entity-id 2 wl-folder-is-group nil)) . "Flagged") ("%Trash" . "Trash") (#("%INBOX" 0 6 (wl-folder-entity-id 1 wl-folder-is-group nil)) . "Inbox") (#("%[Gmail]/Starred" 0 16 (wl-folder-entity-id 2 wl-folder-is-group nil)) . "Important") (#("%[Gmail]/Sent Mail" 0 18 (wl-folder-entity-id 3 wl-folder-is-group nil)) . "Sent") (#("%[Gmail]/Drafts" 0 15 (wl-folder-entity-id 4 wl-folder-is-group nil)) . "Drafts") (#("%[Gmail]/All Mail" 0 17 (wl-folder-entity-id 11 wl-folder-is-group nil)) . "Archive") (#("%[Gmail]/Trash" 0 14 (wl-folder-entity-id 12 wl-folder-is-group nil)) . "Trash") (#("%[Gmail]/Spam" 0 13 (wl-folder-entity-id 14 wl-folder-is-group nil)) . "Spam") (#("+draft" 0 6 (wl-folder-entity-id 15 wl-folder-is-group nil)) . "Drafts"))))
 '(wl-folder-process-duplicates-alist (quote (("^.*" . hide))) nil nil "
Don't show me any duplicate messages")
 '(wl-folder-window-width 60)
 '(wl-highlight-folder-by-numbers 1)
 '(wl-interactive-exit nil)
 '(wl-interactive-save-folders nil)
 '(wl-interactive-send nil)
 '(wl-message-ignored-field-list (quote ("^.*:")))
 '(wl-message-sort-field-list (quote ("^From" "^Organization:" "^X-Attribution:" "^Subject" "^Date" "^To" "^Cc")))
 '(wl-message-visible-field-list (quote ("^\\(To\\|Cc\\):" "^Subject:" "^\\(From\\|Reply-To\\):" "^Organization:" "^Message-Id:" "^\\(Posted\\|Date\\):" "^\\(Mailer\\|User-Agent\\):" "^\\(List-Post\\):" "^\\(Xref\\):")))
 '(wl-organization "BoostPro Computing")
 '(wl-smtp-authenticate-type nil)
 '(wl-smtp-connection-type nil)
 '(wl-smtp-posting-port nil)
 '(wl-smtp-posting-server "localhost")
 '(wl-smtp-posting-user nil)
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
 '(wl-user-mail-address-list (quote ("dave@boostpro.com" "dave.abrahams@gmail.com" "daveabrahams@gmail.com" "boost.consulting@gmail.com" "david.abrahams@rcn.com" "dave@luannocracy.com")))
 '(x-select-enable-clipboard t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cursor ((default (:background "brown")) (nil nil)))
 '(diff-refine-change ((default nil) (nil (:background "#FFFFC0"))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) (:background "Beige" :foreground "DarkGreen" :slant italic))))
 '(italic ((t (:slant italic :family "Monaco"))))
 '(mode-line ((((class color) (min-colors 88)) (:inherit variable-pitch :background "lightblue" :foreground "black" :box (:line-width -1 :style released-button) :height 1.2))))
 '(rst-level-1-face ((t (:background "grey85" :foreground "black"))) t)
 '(rst-level-2-face ((t (:inherit nil :background "grey78" :foreground "black"))) t)
 '(rst-level-3-face ((t (:background "grey71" :foreground "black"))) t)
 '(rst-level-4-face ((t (:background "grey64" :foreground "black"))) t)
 '(rst-level-5-face ((t (:background "grey57" :foreground "black"))) t)
 '(rst-level-6-face ((t (:background "grey50" :foreground "black"))) t))
