;;; packages.el --- ein Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar ein-packages '(ein websocket request))

;; List of packages to exclude.
;; (defvar ein-excluded-packages '())

(defun ein/init-ein ()
  "Initialize my package"
  (use-package ein
    :config (evil-leader/set-key
              "oi" 'ein:notebooklist-open)))
