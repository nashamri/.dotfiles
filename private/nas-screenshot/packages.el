;;; packages.el --- nas-screenshot Layer packages File for Spacemacs
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

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq nas-screenshot-packages
    '(
      (nas-screenshot :location local)
      ))

;; List of packages to exclude.
(setq nas-screenshot-excluded-packages '())

;; For each package, define a function nas-screenshot/init-<package-name>
;;
(defun nas-screenshot/init-nas-screenshot ()
  "Initialize my package"
  (use-package nas-screenshot
    :defer t
    :commands nas-screenshot))
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
