(setq inhibit-startup-message t)

(scroll-bar-mode -1)   ; Disable visible scrollbar
(tool-bar-mode -1)     ; Disable the toolbar
(tooltip-mode -1)      ; Disable tooltips
(set-fringe-mode 10)   ; Give some breathing room

(menu-bar-mode -1)     ; Disable the menu bar

(set-face-attribute 'default nil :font "JetBrains Mono Nerd Font" :height 120)

(setq-default indent-tabs-mode nil)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Bind Keys

(use-package bind-key)

;; Catppuccin

(use-package catppuccin-theme
  :init (setq catppuccin-flavor 'latte))

(load-theme 'catppuccin :no-confirm)


;; Line Numbers
(column-number-mode)
(global-display-line-numbers-mode t)

(dolist (mode '(term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Which Key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Icons

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-nerd-fonts
  :after all-the-icons)

(use-package nerd-icons)


;; Tabs
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-set-icons t)
  :bind
  ("C-<prior>" . centar-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

(bind-keys :prefix "C-t"
           :prefix-map tab-prefix-map
           ("f" . centaur-tabs-forward)
           ("b" . centaur-tabs-backward))


;; Dired
(use-package dired-rsync
  :bind (:map dired-mode-map
              ("C-x d" . dired-rsync)))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

;; Company
(use-package company
  :ensure t
  :init
  (global-company-mode 1)
  :hook (after-init . global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.1
        company-tooltip-align-annotations t
        company-backends '(company-capf)))


;; Edit files with sudo privileges
(use-package sudo-edit)

;; Project Management
;(use-package projectile
;  :ensure t
;  :config
;  (projectile-mode +1)
;  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;  (setq projectile-indexing-method 'alien))

;; Magit
(use-package magit)

;; Eglot

;; Built-in Language Server Protocol client for IDE features.
 
  (use-package eglot
    :ensure t
    :hook ((python-mode . eglot-ensure)
           (haskell-mode . eglot-ensure)
           (haskell-literate-mode . eglot-ensure)
           (c-mode . eglot-ensure)
           (c++-mode . eglot-ensure)
           (rust-mode . eglot-ensure)
           (racket-mode . eglot-ensure)
           (zig-mode . eglot-ensure)
           (nix-mode . eglot-ensure)
           (go-mode . eglot-ensure)
           (idris-mode . eglot-ensure)
           (lua-mode . eglot-ensure)
           (koka-mode . eglot-ensure))
    :bind (:map eglot-mode-map
                ("C-c l r" . eglot-rename)
                ("C-c l a" . eglot-code-actions)
                ("C-c l f" . eglot-format)
                ("C-c l h" . eldoc-doc-buffer)
                ("C-c l d" . xref-find-definitions)
                ("C-c l R" . xref-find-references)
                ("C-c l n" . flymake-goto-next-error)
                ("C-c l e" . flymake-goto-prev-error))
    :custom
    ;; Performance optimizations
    (eglot-events-buffer-size 0)
    (eglot-sync-connect nil)
    (eglot-autoshutdown t)
    (eglot-send-changes-idle-time 0.5)
    :config
    ;; Enable which-key integration
    (add-hook 'eglot-managed-mode-hook
              (lambda ()
                (when (bound-and-true-p company-mode)
                  (company-mode -1)
                  (company-mode 1))
                (when (fboundp 'which-key-mode)
                  (which-key-add-key-based-replacements
                    "C-c l" "eglot")))))

;; flymake
(use-package flymake
  :ensure t
  :custom
  (flymake-no-changes-timeout 0.5)
  :config
  (setq flymake-fringe-indicator-position 'left-fringe))

;; Programming languages
(use-package python-mode)
(use-package rust-mode)
(use-package nix-mode :mode "\\.nix\\'")


;; Eshell
(use-package esh-autosuggest
  :ensure t
  :after esh
  :config
  (eshell-mode .esh-autosuggest-mode))

;; Context Menus
(add-hook 'text-mode-hook 'context-menu-mode)
(add-hook 'prog-mode-hook 'context-menu-mode)


;; Native Compilation

(setq native-comp-async-report-warning-errors 'silent)
(setq native-comp-deferred-compilation t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
