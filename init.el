;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; <autoinstall> list the packages you want
; auto-package-update  error: Package `emacs-24.4' is unavailable
(setq package-list '(undo-tree window-numbering projectile multiple-cursors company auto-complete exec-path-from-shell auto-package-update windresize smooth-scrolling web-beautify highlight-parentheses js2-mode ido-vertical-mode ido-ubiquitous smex))

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
(column-number-mode 1)

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
(setq semantic-default-submodes '(
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-scheduler-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-idle-completions-mode
                                  global-semantic-decoration-mode
                                  ; global-semantic-highlight-func-mode
                                  ; global-semantic-stickyfunc-mode
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

; https://www.gnu.org/software/emacs/manual/html_node/elisp/Click-Events.html
; https://www.gnu.org/software/emacs/manual/html_node/emacs/Mouse-Commands.html
(global-set-key [M-mouse-1] 'mouse-set-point)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; smooth-scrolling
; https://www.emacswiki.org/emacs/SmoothScrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-step           1
      scroll-conservatively 10000)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; web-beautify
; https://github.com/yasuyk/web-beautify
; sublime 用的 https://github.com/victorporof/Sublime-HTMLPrettify
; 配置文件用的同一个 ~/.jsbeautifyrc

(require 'web-beautify) ;; Not necessary if using ELPA package
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(define-key js-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'web-mode
  '(define-key web-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))




; 补全括号
(electric-pair-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; highlight-parentheses
; https://www.emacswiki.org/emacs/HighlightParentheses
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; js2-mode
; http://xiaohanyu.me/oh-my-emacs/modules/ome-javascript.html#js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js2-mode-hook
  '(lambda () (progn
    (setq-default js2-basic-offset 2)
    )))



(global-hl-line-mode 1)
(set-face-background 'hl-line "#222")
; To keep syntax highlighting in the current line
(set-face-foreground 'highlight nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; clang-format
; http://clang.llvm.org/docs/ClangFormat.html#vim-integration
; http://releases.llvm.org/download.html
(load "~/.emacs.d/mypackages/clang-format.el")
; (global-set-key (kbd "C-c b") 'clang-format-region)
(global-set-key (kbd "C-c b") 'clang-format-buffer)
(setq clang-format-style-option "llvm")






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ido-ubiquitous
; https://github.com/DarwinAwardWinner/ido-ubiquitous
(ido-mode 1)
(ido-everywhere 1)
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; https://github.com/nonsequitur/smex
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)



(add-to-list 'load-path "~/.emacs.d/mypackages/ido-grid-mode")
(require 'ido-grid-mode)
(ido-grid-mode 1)


