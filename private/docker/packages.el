;;; packages.el --- docker layer packages file for Spacemacs.
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

;;; Code:

(defconst docker-packages
  '(docker))

(defun docker/init-docker ()
  (use-package docker
    :defer t))


;;; packages.el ends here
