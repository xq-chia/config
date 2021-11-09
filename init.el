;; Define the init file
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



;; Keyboard-centric user interface
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq line-number-mode t)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(blink-cursor-mode 0)
(global-hl-line-mode)



;; Theme
(use-package gruvbox-theme
  :config (load-theme 'gruvbox-dark-soft t)
)

  
  
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
;; limit to f, t, w, e, b, j, k, search

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

;; Key Mapping
(general-nmap
  "j" 'evil-next-visual-line
  "k" 'evil-previous-visual-line
  "C-a" 'evil-numbers/inc-at-pt
  "C-x" 'evil-numbers/dec-at-pt
)
(general-nmap
  :prefix "SPC"
  "u" 'undo-tree-visualize
)
(evilem-default-keybindings "SPC")
