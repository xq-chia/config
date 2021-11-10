;; Define the custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
	 '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)




;; UI/UX
(menu-bar-mode -1)     ;; Disable menu bar
(tool-bar-mode -1)     ;; Disable tool bar
(scroll-bar-mode -1)   ;; Disable scroll bar
(setq line-number-mode t)                  ;; Enable line number
(setq display-line-numbers-type 'relative) ;; Display relative line number for line number
(global-hl-line-mode)                      ;; Enable cursor line ruler
(show-paren-mode 1)                        ;; Show closing parens by default
;; Theme
(use-package gruvbox-theme
  :config (load-theme 'gruvbox-dark-soft t)
)

;; Powerline
(use-package powerline
  :config
  (powerline-vim-theme)
)

;; Encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Misc
(setq ring-bell-function 'ignore)         ; Disable bell sound
(fset 'yes-or-no-p 'y-or-n-p)             ; y-or-n-p makes answering questions faster
(electric-pair-mode 1) ; auto parens in pairs
(setq
 indent-tabs-mode nil
 tab-width 4
)
(setq fill-column 80)
(setq vc-follow-symlinks t)
(setq browse-url-browser-function 'eww-browse-url)

;; Hooks
(add-hook 'before-save-hook
      'whitespace-cleanup) ; auto strip whitespace
(add-hook 'before-save-hook
      'delete-trailing-whitespace)    ; Delete trailing whitespace on save
(add-hook 'prog-mode-hook                 ; Show line numbers in programming modes
      (if (and (fboundp 'display-line-numbers-mode) (display-graphic-p))
	  #'display-line-numbers-mode
	#'linum-mode))
(add-hook 'after-init-hook
      'global-company-mode)
;;; Put Emacs auto-save and backup files to /tmp/ or C:/Temp/
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq
   backup-by-copying t                                        ; Avoid symlinks
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t
   auto-save-list-file-prefix emacs-tmp-dir
   auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t))  ; Change autosave dir to tmp
   backup-directory-alist `((".*" . ,emacs-tmp-dir)))

;; Evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-delete t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-cross-lines t)
  (setq evil-respect-visual-line-mode t)
  (setq evil-track-eol nil)
  (setq evil-vsplit-window-right t)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)
  (evil-set-leader nil (kbd "SPC"))
)



;; Undo-Tree
(use-package undo-tree
  :config
  (global-undo-tree-mode)
  (setq undo-tree-auto-save-history t)
)



;; Evil-Matchit
(use-package evil-matchit
  :config
  (global-evil-matchit-mode 1)
)
;; Evil-Easymotion
(use-package evil-easymotion)
;; require manual remap

;; Evil-numbers
(use-package evil-numbers)
;; Evil-commentary
(use-package evil-commentary
  :config
  (evil-commentary-mode)
)
;; Evil-surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
)



;; General
(use-package general
  :config
  (general-evil-setup)
)




;; Dashboard
(use-package dashboard
  :ensure t
  :after (all-the-icons projectile)
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-items '((recents . 5)
	  (bookmarks .  5)
	  (projects . 5)
	  (agenda . 5)
	  (registers . 5)))
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-navigator t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  ;;(setq dashboard-set-navigator t)
  ;;(setq dashboard-navigator-buttons '(icon title help action face prefix suffix))
  (setq dashboard-set-init-info t)
  (setq dashboard-week-agenda t)
  (setq dashboard-filter-agenda-entry 'dashboard-no-filter-agenda)
)



;; All The Icons
(use-package all-the-icons
  :if (display-graphic-p)
)


;; Projectile
(use-package projectile)
;; Which-Key
(use-package which-key
  :config
  (which-key-mode)
)
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-auto-commit t)
)

;; Key Mapping
(general-nmap
  "j" 'evil-next-visual-line
  "k" 'evil-previous-visual-line
  "C-a" 'evil-numbers/inc-at-pt
  "C-x" 'evil-numbers/dec-at-pt
)
(general-imap
  "C-SPC" 'company-complete
)
(general-nmap
  :prefix "SPC"
  "u" 'undo-tree-visualize
)
(with-eval-after-load 'company
  (dolist (map (list company-active-map company-search-map))
    (define-key map (kbd "<tab>") #'company-select-next)
    (define-key map (kbd "<backtab>") #'company-select-previous)))
(general-nmap
  :keymaps 'evilem-map
  "w" #'evilem-motion-forward-word-begin
  "e" #'evilem-motion-forward-word-end
  "b" #'evilem-motion-backword-word-begin
  "j" #'evilem-motion-next-visual-line
  "k" #'evilem-motion-previous-visual-line
  "f" #'evilem-motion-find-char
  "t" #'evilem-motion-find-char-to
  "[[" #'evilem-motion-backward-section-begin
  "[]" #'evilem-motion-backward-section-end
  "]]" #'evilem-motion-forward-section-begin
  "][" #'evilem-motion-forward-section-end
)
(evilem-default-keybindings "SPC")
(global-set-key [mouse-3] 'mouse-popup-menubar-stuff)

;; Quick Access Emacs Configuration File
(defun Reload ()
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))
(defun Config ()
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory)))
