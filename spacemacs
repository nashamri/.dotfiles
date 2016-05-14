;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     auto-completion
     better-defaults
     clojure
     (colors :variables colors-enable-rainbow-identifiers nil)
     emacs-lisp
     eyebrowse
     git
     github
     html
     ipython-notebook
     javascript
     latex
     list-processes+
     markdown
     org
     ob-ipython
     (python
      :variables
      python-auto-set-local-pyenv-version 'on-project-switch
      python-test-runner 'pytest)
     ;; python
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     ranger
     semantic
     spell-checking
     syntax-checking
     version-control
     )
   dotspacemacs-additional-packages '()
   dotspacemacs-excluded-packages '()
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'hybrid
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '(recents projects)
   dotspacemacs-startup-recent-list-size 5
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight demibold
                               :width normal
                               :powerline-scale 1.2)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-command-key ":"
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-micro-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers nil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  )

(defun dotspacemacs/user-config ()

  ;;;; keybindings
  (define-key evil-normal-state-map "H" 'evil-beginning-of-line)
  (define-key evil-normal-state-map "L" 'evil-end-of-line)

  ;;;; options
  (setq powerline-default-separator nil)
  (setq vc-follow-symlinks t)
  (setq-default truncate-lines t) ; no wrapping lines
  (setq indent-tabs-mode nil) ; use space instead of tab
  (setq ffap-machine-p-known 'reject) ; to stop pinging hosts with find-file-at-point

  ;; web
  (setq web-mode-markup-indent-offset 2)

  ;;;; python
  (setq python-indent-offset 4)
  (setenv "WORKON_HOME" "~/.pyenv/versions")
  ;; (setq python-shell-interpreter "ipython2")

  ;;;; helper functions
  (defun sort-words (reverse beg end)
    (interactive "*P\nr")
    (sort-regexp-fields reverse "\\w+" "\\&" beg end))

  (defun sort-symbols (reverse beg end)
    (interactive "*P\nr")
    (sort-regexp-fields reverse "\\(\\sw\\|\\s_\\)+" "\\&" beg end))

  ;;;; org
  (defun nasser/export-supervisory-meeting ()
    (interactive)
       "Exports pdf of my supervisory meetings."
       (org-latex-export-to-pdf nil t nil nil nil))
  (setq org-agenda-files (list "~/Dropbox/org/phd.org"))
  (setq org-capture-templates
        '(("p" "PhD" entry
           (file "~/Dropbox/org/phd.org") "* TODO %?" :clock-in t :clock-keep t)
          ("P" "PhD with clipboard" entry
           (file "~/Dropbox/org/phd.org") "* TODO %? %x" :clock-in t :clock-keep t))
        )
  ;; (setq org-latex-pdf-process (quote ("texi2dvi --pdf --clean --verbose --batch %f")))
  (setq org-latex-pdf-process (quote ("latexmk -pdf %f")))
  (setq org-confirm-babel-evaluate nil)
  (defun org-export-ignore-headlines (data backend info)
    "Remove headlines tagged \"ignore\" retaining contents and promoting children.
Each headline tagged \"ignore\" will be removed retaining its
contents and promoting any children headlines to the level of the
parent."
    (org-element-map data 'headline
      (lambda (object)
        (when (member "ignore" (org-element-property :tags object))
          (let ((level-top (org-element-property :level object))
                level-diff)
            (mapc (lambda (el)
                    ;; recursively promote all nested headlines
                    (org-element-map el 'headline
                      (lambda (el)
                        (when (equal 'headline (org-element-type el))
                          (unless level-diff
                            (setq level-diff (- (org-element-property :level el)
                                                level-top)))
                          (org-element-put-property el
                                                    :level (- (org-element-property :level el)
                                                              level-diff)))))
                    ;; insert back into parse tree
                    (org-element-insert-before el object))
                  (org-element-contents object)))
          (org-element-extract-element object)))
      info nil)
    data)
  (add-hook 'org-export-filter-parse-tree-functions 'org-export-ignore-headlines)

  ;; scale latex equations
  (eval-after-load 'org
    '(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0)))
  (setq font-latex-fontify-sectioning 1.0)

  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
