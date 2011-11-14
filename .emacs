(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(blink-cursor-mode nil)
 '(case-fold-search t)
 '(column-number-mode t)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(current-language-environment "UTF-8")
 '(cursor-in-non-selected-windows t)
 '(default-input-method "rfc1345")
 '(dired-dwim-target t)
 '(dired-guess-shell-gnutar "/usr/bin/tar")
 '(dired-listing-switches "-Al")
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-mode t nil (time))
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode t)
 '(idle-update-delay 0.25)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(lpr-printer-switch "-d")
 '(mouse-wheel-mode t nil (mwheel))
 '(ps-line-number t)
 '(ps-line-number-start 10)
 '(ps-line-number-step 10)
 '(ps-n-up-printing 2)
 '(ps-paper-type (quote a4))
 '(ps-printer-name-option "-d")
 '(ps-spool-config (quote setpagedevice))
 '(ps-spool-duplex t)
 '(ps-spool-tumble t)
 '(ps-zebra-stripe-height 1)
 '(ps-zebra-stripes t)
 '(python-indent 8)
 '(require-final-newline t)
 '(save-place t nil (saveplace))
 '(scalable-fonts-allowed t)
 '(show-paren-mode t nil (paren))
 '(show-trailing-whitespace t)
 '(size-indication-mode t)
 '(tool-bar-mode nil nil (tool-bar))
 '(truncate-partial-width-windows nil)
 '(use-dialog-box nil)
 '(use-file-dialog nil)
 '(whitespace-style (quote (face tabs spaces trailing lines space-before-tab newline indentation empty space-after-tab space-mark tab-mark newline-mark)))
 '(x-stretch-cursor t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "snow" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "unknown" :family "Inconsolata"))))
 '(border ((t (:background "black"))))
 '(cursor ((t (:background "red"))))
 '(font-lock-constant-face ((((class color) (min-colors 88) (background light)) (:foreground "DarkSlateBlue"))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) (:foreground "Brown"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background light)) (:foreground "#807020"))))
 '(hl-line ((t (:inherit highlight :background "#ffff88"))))
 '(mmm-code-submode-face ((t (:background "Gray95"))))
 '(mode-line ((((type x w32 mac) (class color)) (:background "grey" :foreground "black" :box (:line-width -1 :style released-button)))))
 '(region ((((class color) (min-colors 88) (background dark)) (:background "yellow" :foreground "black"))))
 '(sh-heredoc ((((class color) (background light)) (:foreground "tan4"))))
 '(tool-bar ((((type x w32 mac) (class color)) (:background "grey" :foreground "black" :box (:line-width 1 :style released-button)))))
 '(trailing-whitespace ((nil (:foreground "red" :underline t)))))

;(setq initial-frame-alist
;      (cons '(cursor-type . bar)
;            (copy-alist initial-frame-alist)))
;(setq default-frame-alist
;      (cons '(cursor-type . bar)
;            (copy-alist default-frame-alist)))

;; UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

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

;;; http://www.emacswiki.org/emacs/BackupDirectory
;(setq
; backup-by-copying t      ; don't clobber symlinks
; backup-directory-alist
; '(("." . "~/.emacs-saves"))    ; don't litter my fs tree
; delete-old-versions t
; kept-new-versions 6
; kept-old-versions 2
; version-control t       ; use versioned backups
; )

;; Nuke whitespaces when writing to a file
(add-hook 'before-save-hook 'whitespace-cleanup)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

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
    (if (string-match "/.*:[0-9]+:.*$" selection)
        (let ((file (replace-regexp-in-string "\\(/.*\\):[0-9]+:.*$" "\\1" selection))
              (line (replace-regexp-in-string "/.*:\\([0-9]+\\):.*$" "\\1" selection)))
          (if (file-readable-p file)
              (progn
                (find-file file)
                (goto-char (point-min)) (forward-line (1- (string-to-number line))))
            (error (concat "Unknown file " file))))
      (if (string-match "/.*:\\[[0-9]+,[0-9]+\\].*$" selection)
          (let ((file (replace-regexp-in-string "\\(/.*\\):\\[[0-9]+,[0-9]+\\].*$" "\\1" selection))
                (line (replace-regexp-in-string "/.*:\\[\\([0-9]+\\),[0-9]+\\].*$" "\\1" selection))
                (col  (replace-regexp-in-string "/.*:\\[[0-9]+,\\([0-9]+\\)\\].*$" "\\1" selection)))
            (if (file-readable-p file)
                (progn
                  (find-file file)
                  (goto-char (point-min)) (forward-line (1- (string-to-number line)))
                  (beginning-of-line)
                  (forward-char (string-to-number col)))
              (error (concat "Unknown file " file))))
        (error "Bad string in clipboard, ignoring")))))

(global-set-key "\C-x\C-y" 'open-file-from-clipboard)

;; FIXMEs and other TODOs
;(require 'fic-mode)
;(add-hook 'c++-mode-hook 'turn-on-fic-mode)
;(add-hook 'emacs-lisp-mode-hook 'turn-on-fic-mode)
;(add-hook 'python-mode-hook 'turn-on-fic-mode)

;; Printing
(defun do-print-buffer()
  "Print the buffer if confirmed"
  (interactive)
  (if (y-or-n-p "Really print? ")
      (ps-print-buffer)))
(global-set-key "\C-xp" 'do-print-buffer)

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

(menu-bar-mode nil)
(scroll-bar-mode nil)
(setq inhibit-startup-message t)

;; ----------------------------------------------------------------------
;; Tags extensions
(global-set-key "\M-?" 'tags-search)
;(global-set-key "\M-?" 'tags-query-replace)

;; ----------------------------------------------------------------------
;; More key settings
(global-set-key "\M-gt" 'auto-revert-tail-mode)

;; ----------------------------------------------------------------------
;; Make scripts executable
;; thanks to http://www.masteringemacs.org/articles/2011/01/19/script-files-executable-automatically/

(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

;; ----------------------------------------------------------------------
;; ZENBURN
;; This theme is great, just be sure to comment out the underlined highlight
;; (also needs color-theme)
;; http://www.emacswiki.org/emacs/download/zenburn.el
(require 'zenburn)
(zenburn)

;; ----------------------------------------------------------------------
;; Default C styles
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (c-mode . "k&r")
                        (other . "linux")))

;;; ----------------------------------------------------------------------
;;; Tabs for python and makefiles

(defun my-tabs-python-hook ()
  (setq indent-tabs-mode t))
(add-hook 'python-mode-hook 'my-tabs-python-hook)

(defun my-tabs-makefile-hook ()
  (setq indent-tabs-mode t))
(add-hook 'makefile-mode-hook 'my-tabs-makefile-hook)

;;; ----------------------------------------------------------------------
;; auto compile elisp files after save
(add-hook 'emacs-lisp-mode-hook (lambda () (add-hook 'after-save-hook 'emacs-lisp-byte-compile t t)) )


;;; ----------------------------------------------------------------------
;; make buffer names easily identifiable
(require 'uniquify) ; bundled with GNU Emacs 23.2.1 or earlier
(setq uniquify-buffer-name-style 'forward)


;; ----------------------------------------------------------------------


(defun go-to-my-project ()
  (let ((curproj (getenv "CURRENT_PROJECT")))
    (let ((project-file
           (expand-file-name (if curproj
                                 (concat "~/.projects/" curproj "/project.el")
                               "~/.projects/.@current/project.el"))))
      (message (concat "Project file: " project-file))
      (if (file-exists-p project-file)
          (load project-file)
        (message (concat "Unknown project file: " project-file))))))

;; Project management
(defun goto-my-project ()
  "Go to the latest project"
  (interactive)
  (go-to-my-project))

(global-set-key "\M-gp" 'goto-my-project)
(go-to-my-project)
