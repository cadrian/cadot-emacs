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
 '(current-language-environment "English")
 '(cursor-in-non-selected-windows t)
 '(dired-dwim-target t)
 '(dired-guess-shell-gnutar "/usr/bin/tar")
 '(dired-listing-switches "-Al")
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-mode t nil (time))
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode t)
 '(idle-update-delay 0.25)
 '(indicate-empty-lines t)
 '(lpr-printer-switch "-d")
 '(menu-bar-mode t nil (menu-bar))
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
 '(require-final-newline (quote ask))
 '(save-place t nil (saveplace))
 '(scalable-fonts-allowed t)
 '(show-paren-mode t nil (paren))
 '(show-trailing-whitespace t)
 '(size-indication-mode t)
 '(tool-bar-mode nil nil (tool-bar))
 '(truncate-partial-width-windows nil)
 '(use-dialog-box nil)
 '(use-file-dialog nil)
 '(whitespace-auto-cleanup t)
 '(whitespace-modes (quote (ada-mode asm-mode autoconf-mode awk-mode c-mode c++-mode cc-mode change-log-mode cperl-mode electric-nroff-mode emacs-lisp-mode f90-mode fortran-mode html-mode html3-mode java-mode jde-mode ksh-mode latex-mode LaTeX-mode lisp-mode m4-mode makefile-mode modula-2-mode nroff-mode objc-mode pascal-mode perl-mode prolog-mode python-mode scheme-mode sgml-mode sh-mode shell-script-mode simula-mode tcl-mode tex-mode texinfo-mode vrml-mode xml-mode eiffel-mode))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "snow" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "unknown" :family "Inconsolata"))))
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

(defun tabs-eiffel-mode-hook ()
 (message " Loading tabs-eiffel-mode-hook...")
 (setq indent-tabs-mode t))
(add-hook 'eiffel-mode-hook 'tabs-eiffel-mode-hook)

(setq initial-frame-alist
      (cons '(cursor-type . bar)
            (copy-alist initial-frame-alist)))
(setq default-frame-alist
      (cons '(cursor-type . bar)
            (copy-alist default-frame-alist)))

(setq locale-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; http://www.emacswiki.org/emacs/BackupDirectory
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs-saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t       ; use versioned backups
 )

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


(let ((curproj (getenv "CURRENT_PROJECT")))
  (let ((project-file
	 (expand-file-name (if curproj
			       (concat "~/.projects/" curproj "/project.el")
			     "~/.projects/.@current/project.el"))))
    (message (concat "Project file: " project-file))
    (if (file-exists-p project-file)
	(load project-file)
      (message (concat "Unknown project file: " project-file)))))
