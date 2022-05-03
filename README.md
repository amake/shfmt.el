# shfmt.el

Shell script formatting and linting with [shfmt](https://github.com/mvdan/sh)

# Installation

Install shfmt [per instructions](https://github.com/mvdan/sh#shfmt).

shfmt.el is not (yet) on MELPA so install it locally however you like. You will have
to install [`reformatter`](https://github.com/purcell/reformatter.el) and
[`flycheck`](https://www.flycheck.org/en/latest/) separately.

# Configuration

Manual formatting requires no configuration; just call `shfmt-buffer` or
`shfmt-region`. Enable `shfmt-on-save-mode` to auto-format on save. Add this to
the `sh-mode-hook` to enable automatically in new buffers.

Call `flycheck-shfmt-setup` to enable the Flycheck checker.

## Example

Using [`use-package`](https://jwiegley.github.io/use-package/), assuming
installed locally to `lisp/shfmt`:

```elisp
(use-package shfmt
  :ensure nil
  :load-path "lisp/shfmt"
  :ensure-system-package shfmt
  :hook (sh-mode . shfmt-on-save-mode))

(use-package flycheck-shfmt
  :ensure nil
  :after flycheck
  :load-path "lisp/shfmt"
  :config
  (flycheck-shfmt-setup))
```

# License
GPL-3
