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
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)



;; Theme
(use-package gruvbox-theme
  :config (load-theme 'gruvbox-dark-soft t))
  
  
  
;; Evil package configuration
(use-package evil
  :config 
  (evil-mode 1))
