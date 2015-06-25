
;;; Install mouse wheel for scrolling
(mwheel-install)

;;; Turn off beeping
(setq visible-bell t)

;;; Turn off any startup messages
(setq inhibit-startup-message 0)
(setq inhibit-scratch-message nil)

;;; Turn off annoying cordump on tooltip "feature" 
(setq x-gtk-use-system-tooltips nil)

;;; Insert spaces instead of tabs
(setq-default indent-tabs-mode nil)

;;; Line numbers and column numbers
(column-number-mode t)
(line-number-mode t)
(global-linum-mode t)

(custom-set-variables
 '(load-home-init-file t t))
(custom-set-faces)

(setq c-basic-offset 4) ;; default comments at 4 spaces
(c-set-offset 'innamespace 0) ;; namespaces shouldn't cause indentation
(show-paren-mode t) ;; show matching parenthesis
(c-set-offset 'access-label -2) ;; private, public etc. indent at two spaces

;; load headers files .h as C++ mode not c
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) ;; treat .h as C++ no C
