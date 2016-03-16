;;; packages.el --- demo-it layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: nasser alshammari <nasser@X240>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `demo-it-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `demo-it/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `demo-it/pre-init-PACKAGE' and/or
;;   `demo-it/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst demo-it-packages
  '(demo-it))

(defun demo-it/init-demo-it ()
  :defer t)

;;; packages.el ends here
