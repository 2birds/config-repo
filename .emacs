(setq url-proxy-services ; Behind office proxy.
      '(("no_proxy" . "^\\(localhost\\|10.*\\)")
	("http" . "web-proxy.gbr.hp.com:8080")
	("https" . "web-proxy.gbr.hp.com:8080")
	("ftp" . "web-proxy.gbr.hp.com:8080")))

(add-to-list 'load-path "~/.emacs.d")

(require 'package)
(package-initialize) ; Can't find stuff without this line due to broken ELPA.
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) ; EVIL's repo.

(setq evil-want-C-i-jump nil)
(require 'evil) ; Vim bindings FTW!
(evil-mode 1)
; EVIL mode prevents changing of cursor colour, hence the following hack:
(setq evil-default-cursor (quote (t "#c8c8c8")))

(add-hook 'find-file-hook (lambda ()
			    (linum-mode 1))) ; Line numbers on file load.


(load-theme 'tsdh-dark) ; One of many colour schemes.

(defun insert-file-path ()
  (interactive)
  (insert (buffer-file-name (window-buffer (minibuffer-selected-window)))))

;(global-set-key (kbd "C-i")
		;'(insert-file-path))
(defun new-swig-interface (name)
  "Create a new SWIG interface template."
  (interactive "sModule name:")
  (insert "%module " name "\n%{\n%}"))

;; Rebinding for EVIL compatibility
(require 'etags-select)
;(require 'etags-table)
(global-set-key (kbd "C-x ?")
		'etags-select-find-tag)

(global-set-key (kbd "C-x n")
		'etags-select-next-tag)


; Window switching utility (rather than "C-x o" ad nauseam..)
(require 'win-switch)
(global-set-key "\C-xo" 'win-switch-dispatch)


(require 'psvn)
;(let ((default-directory "~/.emacs.d/"))
;  (normal-top-level-add-subdirs-to-load-path))


(require 'smooth-scrolling)

(defun jump-to-class ()
  (interactive)
  (isearch-backward "class"))

(global-set-key "\C-cc" 'jump-to-class)

(add-to-list 'load-path "~/.emacs.d/slime")
(require 'slime)
(slime-setup '(slime-repl))
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;; Optionally, specify the lisp program you are using. Default is "lisp"
(setq inferior-lisp-program "/usr/bin/sbcl")
