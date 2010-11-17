; (removed job-specific parts)

;; local scripts
(setq load-path (cons "~/.emacs.d/site-lisp" load-path))

;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
(defvar autosave-dir
 (expand-file-name "~/.emacs.d/autosave"))

(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
   (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
    (expand-file-name
     (concat "#%" (buffer-name) "#")))))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir
 (expand-file-name "~/.emacs.d/backup"))

(make-directory backup-dir t)

(setq backup-directory-alist (list (cons "." backup-dir)))


;; Nuke whitespaces when writing to a file
(add-hook 'before-save-hook 'whitespace-cleanup)

;; UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; KEYBOARD
(global-set-key "\M-gg" 'goto-line)


;; PYTHON
(setq-default py-indent-offset 8)


;; custom
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(blink-cursor-mode nil)
 '(c-default-style (quote ((c++-mode . "linux") (java-mode . "java") (other . "gnu"))))
 '(case-fold-search t)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(mouse-wheel-mode t nil (mwheel))
 '(ps-line-number t)
 '(ps-n-up-printing 2)
 '(ps-paper-type (quote a4))
 '(ps-zebra-stripe-height 1)
 '(ps-zebra-stripes t)
 '(save-place t nil (saveplace))
 '(show-paren-mode t nil (paren))
 '(show-trailing-whitespace t)
 '(standard-indent 8)
 '(tool-bar-mode nil nil (tool-bar))
 '(x-stretch-cursor t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "ivory" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "unknown" :family "Inconsolata"))))
 '(cursor ((t (:background "red"))))
 '(mouse ((t (:background "red"))))
 '(trailing-whitespace ((((class color) (background light)) (:underline "red" :weight bold)))))

(menu-bar-mode nil)
(scroll-bar-mode nil)
(setq inhibit-startup-message t)

;; the above helps a little, this totally turns it off and replaces it
;; with a flash:
;; (setq visible-bell 1)

;; Or you can have it play a sound, instead of the normal annoying beep
(setq ring-bell-function (lambda ()
			   (call-process
			    "play" nil 0 nil
			    "/usr/share/sounds/gtk-events/clicked.wav")))

;; some people get upset if you use tabs instead of spaces, but I've
;; never seen anyone get upset for doing things the other way around,
;; so I decided to just use this (in short, uses spaces to indent
;; stuff, not tabs)
(setq-default indent-tabs-mode t)

;; this entry:
;; http://www.emacsblog.org/2007/02/27/quick-tip-add-occur-to-isearch/,
;; linked to this:
;; http://blog.zenspider.com/archives/2007/02/new_category_emacs.html,
;; which gave me this awesome thing.  Hit c-o while doing a c-s search
;; and it does an occur on what your searching for.
(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
	       (regexp-quote isearch-string))))))


;;; color theme -- loses tabs at file saving!!
;(require 'color-theme)
;(eval-after-load "color-theme"
;  '(progn
;     (color-theme-charcoal-black)))


;; Clipboard

;http://www.emacswiki.org/emacs/CopyAndPaste
(defun get-clipboard-contents-as-string (type)
  "Return the value of the clipboard contents as a string."
  (let ((data-types '(TEXT
		      STRING
		      FILE_NAME))
	text)
    (while (and (null text) data-types)
      (setq text (condition-case nil
		     (x-get-selection type (car data-types))
		   (error nil)))
      (setq data-types (cdr data-types)))
    text))

(defun open-file-from-clipboard ()
  "Open a file given by a path in the clipboard."
  (interactive)
  (let ((selection (get-clipboard-contents-as-string 'PRIMARY)))
    (let ((file (replace-regexp-in-string "/\\(.*\\):[0-9]+:.*$" "\\1" selection))
	  (line (replace-regexp-in-string "/.*:\\([0-9]+\\):.*$" "\\1" selection)))
      (if (file-readable-p file)
	  (progn
	    (find-file file)
	    (goto-line (string-to-number line)))
	(error (concat "Unknown file " file))))))

(global-set-key "\C-x\C-y" 'open-file-from-clipboard)

;; FIXMEs and other TODOs

(require 'fic-mode)
(add-hook 'c++-mode-hook 'turn-on-fic-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-fic-mode)
(add-hook 'python-mode-hook 'turn-on-fic-mode)

;; Printing

(global-set-key "\C-xp" 'ps-print-buffer)

;; Set up initialization parameters for python mode:
(require 'smarttabs)
(smart-tabs-advice python-indent-line-1 python-indent)
(autoload 'camelCase-mode "camelCase-mode" nil t)

(add-hook 'python-mode-hook
	  (lambda ()
	    ;(c-subword-mode t)
	    (setq indent-tabs-mode t)
	    (setq tab-width (default-value 'tab-width))))
