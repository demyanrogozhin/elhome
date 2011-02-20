# ElHome - the _solvent_ Emacs configuration framework

> _"Keep it together"_

## Installation

Evaluate this elisp.  You can copy it (to the clipboard or kill
ring such that ‘C-y’ will insert it) and then ‘M-: C-y RET’

     (url-retrieve
       "https://github.com/dabrahams/elhome/raw/framework/elhome-install.el"
       (lambda (s) (end-of-buffer) (eval-print-last-sexp)))

## Congratulations, ELHOME is now installed!

There are several new directories you'll want to work with.  See the
README files in each one for more details:

* `~/.emacs.d/elhome/` - where everything related to this configuration is stored
* `~/.emacs.d/elhome/startup/` - elisp that is unconditionally loaded as
  early in startup as possible.
* `~/.emacs.d/elhome/settings/` - settings for specific modes, including
  the general customization file settings.el
* `~/.emacs.d/elhome/site-lisp/` - elisp files placed here (or in subdirectories) will be 

Suggestions for more documentation, and especially patches, would be
most welcome here!

## History

This project came out of my second
[.emacs bankruptcy](http://emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/),
because the [first system](http://github.com/dabrahams/elisp) I had
set up had lost modularity and become too closely coupled with my own
configuration.

-Dave Abrahams
