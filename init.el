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
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)



;; Theme
(use-package gruvbox-theme
  :config (load-theme 'gruvbox-dark-soft t))
  
  
;; Undo-Tree
(
use-package undo-tree
  :config
  (global-undo-tree-mode)
)
  
  
    
;; Evil
(
use-package evil
  :ensure t
  :init
  (setq evil-respect-visual-line-mode t)
  :config 
  (evil-mode 1)
  (setq evil-want-C-u-delete t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-search-wrap nil)
  (setq evil-cross-lines t)
  (setq evil-track-eol nil)
  (setq evil-vsplit-window-right t)
  (setq evil-undo-system 'undo-tree)
  (evil-set-leader nil (kbd "SPC"))
)
  
  
  

;; Dashboard
(
use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-navigator t)
  ;;(setq dashboard-set-heading-icons t)
  ;;(setq dashboard-set-file-icons t)
)
