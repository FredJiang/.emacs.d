;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; <autoinstall> list the packages you want
; auto-package-update  error: Package `emacs-24.4' is unavailable
(setq package-list '(undo-tree window-numbering projectile multiple-cursors company auto-complete exec-path-from-shell auto-package-update windresize smooth-scrolling))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; <autoinstall> list the repositories containing them
;; elpa
(require 'package)
(add-to-list 'package-archives 
               '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)


; <autoinstall> fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; <autoinstall> install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; 通用
(global-linum-mode 1) ; always show line numbers

(unless (display-graphic-p)
  (defun fix-linum-color ()
    (interactive)
    (setq linum-format "%d  ")
    (set-face-attribute 'linum nil :foreground "white"))
  (add-hook 'linum-mode-hook 'fix-linum-color)
)


(defalias 'yes-or-no-p 'y-or-n-p)


;; auto-complete
(ac-config-default)


(add-to-list 'load-path "~/.emacs.d/mypackages")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; neotree
;; https://www.emacswiki.org/emacs/NeoTree
;; cd ~/.emacs.d/mypackages/
;; git clone https://github.com/jaypei/emacs-neotree.git neotree
(add-to-list 'load-path "~/.emacs.d/mypackages/neotree")
(require 'neotree)
(put 'erase-buffer 'disabled nil)
(neotree-toggle)
(global-set-key (kbd "<f8>") 'neotree-toggle)
; terminal 中的 color 问题
(unless (display-graphic-p)
    (custom-set-faces
     '(col-highlight ((t (:background "color-233"))))
     '(hl-line ((t (:background "color-233"))))
     '(lazy-highlight ((t (:background "black" :foreground "white" :underline t))))
     '(neo-dir-link-face ((t (:foreground "cyan"))))
     '(neo-file-link-face ((t (:foreground "white")))))
    (custom-set-variables)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
(defun jrh-isearch-with-region ()
  "Use region as the isearch text."
  (when mark-active
    (let ((region (funcall region-extract-function nil)))
      (deactivate-mark)
      (isearch-push-state)
      (isearch-yank-string region))))

(add-hook 'isearch-mode-hook #'jrh-isearch-with-region)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'multiple-cursors)
(global-set-key (kbd "M-n") 'mc/mark-next-like-this)
(global-set-key (kbd "M-p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c m") 'mc/edit-lines)
(global-set-key (kbd "C-c a") 'mc/mark-all-like-this)



;; company
;; http://company-mode.github.io/
(add-hook 'after-init-hook 'global-company-mode)












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; c language
; https://www.emacswiki.org/emacs/ReformatBuffer
(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key (kbd "<f12>") 'indent-buffer)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(setq windmove-wrap-around t)

(require 'window-numbering)
(window-numbering-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-undo-tree-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 关闭 emacs 启动时的页面
(setq inhibit-startup-message 1)
(setq gnus-inhibit-startup-message 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 自动保存
; https://www.emacswiki.org/emacs/AutoSave
(defconst emacs-tmp-dir (format "%s%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
    `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
    `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
    emacs-tmp-dir)

; buffer 的 save 和 worte to disk 是有区别的
(setq auto-save-interval 5
      auto-save-timeout 5)
(defun full-auto-save ()
  (interactive)
  (save-excursion
  (dolist (buf (buffer-list))
    (set-buffer buf)
    (if (and (buffer-file-name) (buffer-modified-p))
      (basic-save-buffer)))))
(add-hook 'auto-save-hook 'full-auto-save)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; semantic
; https://www.gnu.org/software/emacs/manual/semantic.html
(setq semantic-default-submodes '(global-semanticdb-minor-mode
                                  global-semantic-idle-scheduler-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-idle-completions-mode
                                  global-semantic-decoration-mode
                                  ; global-semantic-highlight-func-mode
                                  global-semantic-stickyfunc-mode
                                  global-semantic-mru-bookmark-mode))
(semantic-mode 1)
(global-set-key (kbd "C-c j") 'semantic-ia-fast-jump)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; cscope
; http://cscope.sourceforge.net
; 在项目根目录下运行 cscope-indexer -r
; 快捷键通过 f10 打开菜单看
(add-hook 'c-mode-common-hook
  '(lambda ()
    (require 'xcscope)))


; (global-set-key [M-mouse-1] 'mouse-set-point)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; smooth-scrolling
; https://www.emacswiki.org/emacs/SmoothScrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-step           1
      scroll-conservatively 10000)
