# ElHome - the _solvent_ Emacs configuration framework

> _"Keep it together"_

## Installation

Evaluate this elisp.  You can copy it (to the clipboard or kill
ring such that ‘C-y’ will insert it) and then ‘M-: C-y RET’

     (url-retrieve
       "https://github.com/dabrahams/elhome/raw/master/elhome-install.el"
       (lambda (s) (end-of-buffer) (eval-print-last-sexp)))

This will use el-get to install elhome.  Then, add code to your `.emacs` to do one of two things:

* Load elhome.el manually from your init.el, and then call `(elhome-init)`. Code
  might look like this:

    (load "~/.emacs.d/el-get/elhome/elhome.el")
    (elhome-init)

* Use `el-get` to initialize elhome.  A call to `el-get` might look like this:

    (setq el-get-sources
          '(
            (:name elhome :after elhome-init)
           ))
    (el-get)

  If you're already using el-get to manage your packages, this is probably
  easiest.

## Congratulations, ELHOME is now installed!

There are several new directories you'll want to work with.  See the
README files in each one for more details:

* `~/.emacs.d/elhome/` - where everything related to this configuration is stored
* `~/.emacs.d/elhome/startup/` - elisp that is unconditionally loaded as
  early in startup as possible.
* `~/.emacs.d/elhome/settings/` - settings for specific modes, including
  the general customization file settings.el (which is used as custom-file).
* `~/.emacs.d/elhome/site-lisp/` - placed on load-path, along with any
  subdirectories that contain emacs-lisp files.

## Startup

This is the first order of business for elhome.  Files are loaded in
alphabetical order.  Look at `elhome/startup` for an example.

## Settings

N.B. This feature requires `after-load-functions`, introduced in Emacs 23.2.

Any time a file named `foo.el` is loaded, a file in settings called
`foo-settings.el` is loaded if it exists.  This lets you easily
organize your customizations according to subject matter.

Additionally, `initsplit` is used to split `customize` settings into
different files.  Every `foo-settings.el` file will be used to store
all customized variables and faces with names starting `foo-`.

## Site-lisp

This directory is put on your load path, to facilitate loading
personal code.  Additionally, all subdirectories of `site-lisp` are
explored, and those that contain `.el` files are also put on your load
path, so you can organize however you like, track your own git
submodules, etc. here without having to mess around manually with load
paths.

## Me-minor-mode

Major modes often inconveniently shadow your keyboard
customizations.  One way to get around this is to create a minor mode
solely to contain key bindings.  elhome automatically configures a
minor mode like this called me-minor-mode, which is globally
activated.  So instead of code like

    (define-key global-map (kbd "M-<up>") 'scroll-down-one)

or

    (global-define-key (kbd "M-<up>") 'scroll-down-one)

You can use instead

    (define-key me-minor-mode-map (kbd "M-<up>") 'scroll-down-one)

## You can help

Suggestions for more documentation, and especially patches, would be
most welcome here!

## History

This project came out of my second
[.emacs bankruptcy](http://emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/),
because the [first system](http://github.com/dabrahams/elisp) I had
set up had lost modularity and become too closely coupled with my own
configuration.

-Dave Abrahams
