;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; <autoinstall> list the packages you want
; auto-package-update  error: Package `emacs-24.4' is unavailable
(setq package-list '(undo-tree window-numbering projectile multiple-cursors company auto-complete exec-path-from-shell auto-package-update windresize smooth-scrolling web-beautify highlight-parentheses js2-mode ido-completing-read+ smex go-mode go-eldoc go-autocomplete go-errcheck godoctor flycheck exec-path-from-shell magit web-mode irony company-irony company-irony-c-headers flycheck-irony yasnippet helm dumb-jump))


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
    (setq linum-format "%4d\u2502")
    (set-face-attribute 'linum nil :foreground "white"))
  (add-hook 'linum-mode-hook 'fix-linum-color)
)


(defalias 'yes-or-no-p 'y-or-n-p)


;; auto-complete
(ac-config-default)


(add-to-list 'load-path "~/.emacs.d/mypackages")


; (if (display-graphic-p)
;     (load-GUI-theme))

; (unless (display-graphic-p)
;     (load-Terminal-theme))


; (add-to-list 'load-path "~/.emacs.d/mypackages/all-the-icons")
; (require 'all-the-icons)
; ; ; https://elpa.emacs-china.org/packages/all-the-icons/
; ; ; * Description: A library for inserting Developer icons
; ; ; * Home page: https://github.com/domtronn/all-the-icons.el
; ; ; * Versions: 2.5.2 (melpa-stable), 20170505.13 (melpa)
; ; ; * Dependencies: emacs-24.3, font-lock+-0, memoize-1.0.1
; ; ; https://elpa.emacs-china.org/packages/font-lock+/
; (require 'font-lock+)
; ; (add-to-list 'load-path "~/.emacs.d/mypackages/memoize")
; (require 'memoize)


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


; (defun my/neotree-hook (_unused)
;   (linum-mode))
; (add-hook 'neo-after-create-hook 'my/neotree-hook)
; (add-hook 'neo-after-create-hook 'linum-mode)

; (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

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
; yasnippet
(require 'yasnippet)
(yas-global-mode 1)





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



; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ; smooth-scrolling
; ; https://www.emacswiki.org/emacs/SmoothScrolling
; (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
; (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
; (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
; (setq scroll-step           1
;       scroll-conservatively 10000)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; web-mode                                                                     ;
; http://web-mode.org/                                                         ;
(require 'web-mode)                                                            ;
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))                     ;
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))                 ;
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))                   ;
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))                   ;
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))                       ;
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))                  ;
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))                    ;
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))                     ;
                                                                               ;
                                                                               ;
                                                                               ;
; js2-mode                                                                     ;
; http://xiaohanyu.me/oh-my-emacs/modules/ome-javascript.html#js2-mode         ;
(require 'js2-mode)                                                            ;
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))                        ;
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))                          ;
(setq js2-mode-hook                                                            ;
  '(lambda () (progn                                                           ;
    (setq-default js2-basic-offset 2)                                          ;
    )))                                                                        ;
                                                                               ;
                                                                               ;
                                                                               ;
; web-beautify                                                                 ;
; https://github.com/yasuyk/web-beautify                                       ;
; sublime 用的 https://github.com/victorporof/Sublime-HTMLPrettify             ;
; 配置文件用的同一个 ~/.jsbeautifyrc                                           ;
; sublime 换成 ESLint-Formatter 了                                             ;
(require 'web-beautify) ;; Not necessary if using ELPA package                 ;
(eval-after-load 'js2-mode                                                     ;
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))                   ;
;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')                      ;
(eval-after-load 'js                                                           ;
  '(define-key js-mode-map (kbd "C-c b") 'web-beautify-js))                    ;
                                                                               ;
(eval-after-load 'json-mode                                                    ;
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))                  ;
                                                                               ;
(eval-after-load 'sgml-mode                                                    ;
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))                ;
                                                                               ;
(eval-after-load 'web-mode                                                     ;
  '(define-key web-mode-map (kbd "C-c b") 'web-beautify-html))                 ;
                                                                               ;
(eval-after-load 'css-mode                                                     ;
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




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





(unless (display-graphic-p)
  (global-hl-line-mode 1)
  (set-face-background 'hl-line "#222")
  ; To keep syntax highlighting in the current line
  (set-face-foreground 'highlight nil)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; clang-format
; http://clang.llvm.org/docs/ClangFormat.html#vim-integration
; http://releases.llvm.org/download.html
(load "~/.emacs.d/mypackages/clang-format.el")
; (global-set-key (kbd "C-c b") 'clang-format-region)
; (global-set-key (kbd "C-c b") 'clang-format-buffer)
(setq c-mode-hook
  '(lambda () (progn
    (global-set-key (kbd "C-c b") 'clang-format-buffer)
    )))
(setq clang-format-style-option "llvm")





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; https://github.com/nonsequitur/smex
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido-ubiquitous
;; https://github.com/DarwinAwardWinner/ido-ubiquitous
(ido-mode 1)
(ido-everywhere 1)
; (require 'ido-ubiquitous)
; (ido-ubiquitous-mode 1)
; ido-ubiquitous 换成 ido-completing-read+
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido-grid-mode
(add-to-list 'load-path "~/.emacs.d/mypackages/ido-grid-mode")
(require 'ido-grid-mode)
(ido-grid-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; helm
; 作用和 ido 差不多，但上手难
(require 'helm-config)
(helm-mode 1)
; (global-set-key (kbd "M-x") #'helm-M-x)
; (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
; (global-set-key (kbd "C-x C-f") #'helm-find-files)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x C-b") 'ibuffer)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ; https://www.emacswiki.org/emacs/AsmMode
; (defun my-asm-mode-hook ()
;   ;; you can use `comment-dwim' (M-;) for this kind of behaviour anyway
;   (local-unset-key (vector asm-comment-char))
;   ;; asm-mode sets it locally to nil, to "stay closer to the old TAB behaviour".
;   (setq tab-always-indent (default-value 'tab-always-indent)))

; (add-hook 'asm-mode-hook #'my-asm-mode-hook)


(setq-default indent-tabs-mode nil)


(defun go-mode-setup ()
  (setq compile-command "go build -v && go test -v && go vet")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  ; (add-hook 'before-save-hook 'gofmt-before-save)
  (global-set-key (kbd "C-c b") 'gofmt)
  (local-set-key (kbd "C-c j") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)
(require 'go-autocomplete)
(require 'auto-complete-config)

; 下面这个报错，why？
; (add-to-list 'yas-snippet-dirs "~/.emacs.d/mypackages/yasnippet-go")


; 下面这个报错，why？
; (use-package flycheck
;   :ensure t
;   :init (global-flycheck-mode))
(global-flycheck-mode)



(add-to-list 'load-path "~/.emacs.d/mypackages/disaster")
(require 'disaster)
(define-key c-mode-base-map (kbd "C-c d") 'disaster)


(exec-path-from-shell-initialize)








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 鼠标滚动和点击
; https://gist.github.com/ftrain/8443721

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)
(require 'xt-mouse)
(xterm-mouse-mode)
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))

(setq mouse-wheel-follow-mouse 't)

(defvar alternating-scroll-down-next t)
(defvar alternating-scroll-up-next t)

(defun alternating-scroll-down-line ()
  (interactive "@")
    (when alternating-scroll-down-next
;      (run-hook-with-args 'window-scroll-functions )
      (scroll-down-line))
    (setq alternating-scroll-down-next (not alternating-scroll-down-next)))

(defun alternating-scroll-up-line ()
  (interactive "@")
    (when alternating-scroll-up-next
;      (run-hook-with-args 'window-scroll-functions)
      (scroll-up-line))
    (setq alternating-scroll-up-next (not alternating-scroll-up-next)))

(global-set-key (kbd "<mouse-4>") 'alternating-scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'alternating-scroll-up-line)


; kills to the left
(global-set-key "\M-k" '(lambda () (interactive) (kill-line 0)))

; http://ergoemacs.org/emacs/whitespace-mode.html
; make whitespace-mode use just basic coloring
(setq whitespace-style (quote
  ; (spaces tabs space-mark tab-mark newline newline-mark)))
  (spaces tabs space-mark tab-mark)))

(global-whitespace-mode 1)
; https://lists.gnu.org/archive/html/bug-gnu-emacs/2016-09/msg00461.html
; (set-face-attribute 'whitespace-space nil :background nil :foreground "gray30")
; (set-face-background 'whitespace-space nil)
; (set-face-foreground 'whitespace-space "gray10")
; (set-face-background 'whitespace-newline nil)
; (set-face-foreground 'whitespace-newline "gray10")


(require 'grep)
(grep-apply-setting 'grep-find-command '("find . -type f ! -path \"*/\\.git/*\" ! -path \"*/node_modules/*\" -exec grep -nH -C 2 -e '' {} +" . 87))
(grep-apply-setting 'grep-command "grep -nH -C 2 -e ")


; https://stackoverflow.com/questions/10867199/emacs-in-terminal-meta-arrow-keybindings
(add-hook 'term-setup-hook
  '(lambda ()
     (define-key function-key-map "\e[1;9A" [M-up])
     (define-key function-key-map "\e[1;9B" [M-down])
     (define-key function-key-map "\e[1;9C" [M-right])
     (define-key function-key-map "\e[1;9D" [M-left])))


(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)



(set-default 'truncate-lines t)
; To have emacs wordwrap OFF add:
;  (setq-default truncate-lines 1)
; To have emacs word-wrap ON add:
;  (setq-default truncate-lines 0)
(add-hook 'eshell-mode-hook
          (lambda () 
             (setq truncate-lines nil)))


(require 'goto-chg)
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)

(add-to-list 'load-path "~/.emacs.d/mypackages/evil")
(require 'evil)

(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

(evil-mode 1)
(setq evil-default-state 'emacs)

(add-to-list 'load-path "~/.emacs.d/mypackages/powerline")
(require 'powerline)
; (powerline-default-theme)

(add-to-list 'load-path "~/.emacs.d/mypackages/airline-themes")
(require 'airline-themes)
(load-theme 'airline-light t)


; 好像很卡
; (add-to-list 'load-path "~/.emacs.d/mypackages/highlight-thing")
; (require 'highlight-thing)
; (global-highlight-thing-mode)


; http://rejeep.github.io/emacs/elisp/2010/03/11/duplicate-current-line-or-region-in-emacs.html
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)


(require 'org)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/org/work.org"
                             "~/org/study.org"
                             "~/org/todo.org"
                             "~/org/home.org"))



; irony company-irony company-irony-c-headers flycheck-irony
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))


(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


(require 'dumb-jump)
(dumb-jump-mode)
(global-set-key (kbd "C-c g") 'dumb-jump-go)

; (list-matching-lines-default-context-lines 2)
; auto produced


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(list-matching-lines-default-context-lines 2))
