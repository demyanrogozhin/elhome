# ElHome

This project came out of my second
[.emacs bankruptcy](http://emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/),
because the [first system](http://github.com/dabrahams/elisp) I had
set up had lost modularity and become too closely coupled with my own
configuration.

## Directories

* `~/.emacs.d/elhome/` - where everything related to this configuration is stored
* `~/.emacs.d/elhome/init.d/` - elisp that is unconditionally loaded as
  early in startup as possible
* `~/.emacs.d/elhome/etc/` - settings for specific modes, including
  the general customization file settings.el
* `~/.emacs.d/elhome/lib/` - elisp that is installed in the load-path
  so it can be easily found by `load-library`, `require`, etc.
