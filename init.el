;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; <autoinstall> list the packages you want
; auto-package-update  error: Package `emacs-24.4' is unavailable
(setq package-list '(undo-tree window-numbering projectile multiple-cursors company auto-complete exec-path-from-shell auto-package-update windresize smooth-scrolling web-beautify highlight-parentheses js2-mode ido-completing-read+ smex go-mode go-eldoc go-autocomplete go-errcheck godoctor flycheck exec-path-from-shell magit web-mode irony company-irony company-irony-c-headers flycheck-irony yasnippet helm dumb-jump nlinum linum-relative wttrin emmet-mode meghanada use-package hydra smartparens rainbow-delimiters highlight-symbol groovy-mode gradle-mode eslint-fix ag dash s paradox helm-dash helm-ag helm-projectile ghub))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; <autoinstall> list the repositories containing them                          ;
;; elpa                                                                        ;
(require 'package)                                                             ;
(add-to-list 'package-archives                                                 ;
               '("melpa-stable" . "http://stable.melpa.org/packages/") t)      ;
(package-initialize)                                                           ;
                                                                               ;
; <autoinstall> fetch the list of packages available                           ;
(unless package-archive-contents                                               ;
  (package-refresh-contents))                                                  ;
                                                                               ;
; <autoinstall> install the missing packages                                   ;
(dolist (package package-list)                                                 ;
  (unless (package-installed-p package)                                        ;
    (package-install package)))                                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
;; This is only needed once, near the top of the file                          ;
(eval-when-compile                                                             ;
  ;; Following line is not needed if use-package.el is in ~/.emacs.d           ;
  ; (add-to-list 'load-path "<path where use-package is installed>")           ;
  (require 'use-package))                                                      ;
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥




; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
; 更新 package
(auto-package-update-maybe) ; 定期自动更新所有 package
; paradox-upgrade-packages ;      手动更新所有 package
; auto-package-update-now ;       手动更新所有 package
; package-menu-mark-xxx ; 先标记，再做特殊处理
(require 'paradox)
(paradox-enable)
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥




; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
; http://spacemacs.org/layers/+tools/dash/README.html
(add-to-list 'load-path "~/.emacs.d/mypackages/dash-at-point")
(autoload 'dash-at-point "dash-at-point"
          "Search the word at point with Dash." t nil)
; (global-set-key "\C-cd" 'dash-at-point)
; (global-set-key "\C-ce" 'dash-at-point-with-docset)

; helm-dash-install-docset
; helm-dash-activate-docset
(setq helm-dash-browser-func 'eww)

(defun helm-dash-use-go-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("Go")))
(add-hook 'go-mode-hook 'helm-dash-use-go-doc)
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; 通用
(column-number-mode 1)


; (set-language-environment "UTF-8")
; (set-default-coding-systems 'utf-8)
; (set-buffer-file-coding-system 'utf-8-unix)
; (set-clipboard-coding-system 'utf-8-unix)
; (set-file-name-coding-system 'utf-8-unix)
; (set-keyboard-coding-system 'utf-8-unix)
; (set-next-selection-coding-system 'utf-8-unix)
; (set-selection-coding-system 'utf-8-unix)
; (set-terminal-coding-system 'utf-8-unix)
; (setq locale-coding-system 'utf-8)
; (prefer-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (global-linum-mode 1) ; always show line numbers                             ;
; (unless (display-graphic-p)                                                  ;
;   (defun fix-linum-color ()                                                  ;
;     (interactive)                                                            ;
;     (setq linum-format "%4d\u2502")                                          ;
;     (set-face-attribute 'linum nil :foreground "white"))                     ;
;   (add-hook 'linum-mode-hook 'fix-linum-color)                               ;
; )                                                                            ;
                                                                               ;
; (global-nlinum-mode 1) ; always show line numbers                            ;
; (unless (display-graphic-p)                                                  ;
;   (defun fix-nlinum-color ()                                                 ;
;     (interactive)                                                            ;
;     (setq nlinum-format "%4d\u2502")                                         ;
;     (set-face-attribute 'linum nil :foreground "white"))                     ;
;   (add-hook 'nlinum-mode-hook 'fix-nlinum-color)                             ;
; )                                                                            ;
; (add-hook 'eshell-mode-hook (lambda () (nlinum-mode -1)))                    ;

(global-linum-mode 1) ; always show line numbers
; (setq linum-relative-user-format "%4d\u2502") 
; (set-face-attribute 'linum nil :foreground "white")
(require 'linum-relative)
(linum-on) 
(linum-relative-on)
(custom-set-faces '(linum-relative-current-face
                    ((t :inherit linum :foreground "red" :background "white" :weight bold))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defalias 'yes-or-no-p 'y-or-n-p)


;; auto-complete
(ac-config-default)


(add-to-list 'load-path "~/.emacs.d/mypackages")



; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
(require 'vline)
(require 'hl-line+)
(require 'col-highlight)
(require 'crosshairs)
; (crosshairs t) ; 显示行号有问题
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥





(add-to-list 'load-path "~/.emacs.d/mypackages/highlight-indent-guides")
(require 'highlight-indent-guides)
(setq highlight-indent-guides-auto-enabled nil)
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-auto-character-face-perc 20)
(set-face-foreground 'highlight-indent-guides-character-face "dimgray")
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)


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





; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
; (setq recenter-positions '(middle top bottom))
(setq recenter-positions '(top bottom))
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥


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


; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
(require 'groovy-mode)
; (add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))

(require 'gradle-mode)
; (gradle-mode 1)
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥


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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; https://github.com/smihica/emmet-mode                                        ;
; emmet-mode                                                                   ;
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes       ;
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.     ;
(global-set-key (kbd "C-c e") 'emmet-expand-line)                              ;
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




; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
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

; 在 ubuntu 上，ido-yes-or-no 没安装成功
; (require 'ido-yes-or-no)
; (ido-yes-or-no-mode 1)

(require 'icomplete)
(icomplete-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido-grid-mode
(add-to-list 'load-path "~/.emacs.d/mypackages/ido-grid-mode")
(require 'ido-grid-mode)
(ido-grid-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; helm
; 作用和 ido 差不多，但上手难
(require 'helm-config)
; (helm-mode 1)
; (global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

(setq helm-ff-skip-boring-files t)
; (setq helm-ff-file-name-history-use-recentf t)
(setq helm-boring-file-regexp-list
'("\\.DS_Store" "\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "~$"
  "\\.so$" "\\.a$" "\\.elc$" "\\.fas$" "\\.fasl$" "\\.pyc$" "\\.pyo$"))

; (setq helm-boring-buffer-regexp-list '("\\*Messages\\*" "\\*Help\\*" "\\*Shell Command Output" "\\*Flycheck error message" "\\*meghanada-" "\\*wttr.in - "))
(setq helm-boring-buffer-regexp-list '("\\*" "^[^.]*$"))
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥



; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
; (projectile-mode t)
(require 'helm-projectile)
(helm-projectile-on)
(global-set-key (kbd "C-c p h") 'helm-projectile)

; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥


; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
;; helm from https://github.com/emacs-helm/helm
(require 'helm)

;; Locate the helm-swoop folder to your path
(add-to-list 'load-path "~/.emacs.d/mypackages/helm-swoop")
(require 'helm-swoop)

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; Move up and down like isearch
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows t)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-horizontally)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

;; ;; Go to the opposite side of line from the end or beginning of line
(setq helm-swoop-move-to-line-cycle t)

;; Optional face for line numbers
;; Face name is `helm-swoop-line-number-face`
(setq helm-swoop-use-line-number-face t)

;; If you prefer fuzzy matching
(setq helm-swoop-use-fuzzy-match t)
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
(require 'ag)
(setq ag-highlight-search t)
(setq ag-arguments (append '("--before=1" "--after=1") ag-arguments))
; 或者 helm-ag
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥

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
; (define-key c-mode-base-map (kbd "C-c d") 'disaster)



(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))








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
(grep-apply-setting 'grep-find-command '("find . -type f ! -path \"*/\\.git/*\" ! -path \"*/node_modules/*\" ! -path \"*/components/*\" -exec grep -nH -C 2 -e '' {} +" . 112))
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
(evil-define-key 'normal neotree-mode-map (kbd "a") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "C-x C-f") #'helm-find-files)


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


(require 'smartparens-config)
(add-hook 'prog-mode-hook #'smartparens-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
(add-to-list 'load-path (expand-file-name "~/.emacs.d/mypackages/origami/"))
(require 'origami)
; (global-origami-mode t)
(add-hook 'prog-mode-hook #'global-origami-mode)
(global-set-key [f2] 'origami-toggle-node)
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥


; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
(require 'highlight-symbol)
(add-hook 'prog-mode-hook #'highlight-symbol-mode)
(global-set-key [f3] 'highlight-symbol-prev)
(global-set-key [f4] 'highlight-symbol-next)
; (global-set-key [(control f3)] 'highlight-symbol)
; (global-set-key [(shift f3)] 'highlight-symbol-prev)
; (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥


; ↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧↧
(add-to-list 'load-path "~/.emacs.d/mypackages/google-styleguide")
(require 'google-c-style)

(use-package autodisass-java-bytecode
  :ensure t
  :defer t)

(use-package meghanada
  :defer t
  :init
  (add-hook 'java-mode-hook
            (lambda ()
              (google-set-c-style)
              (google-make-newline-indent)
              (meghanada-mode t)
              (global-set-key (kbd "C-c b") 'meghanada-code-beautify)))

  :config
  (use-package realgud
    :ensure t)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq c-basic-offset 2)
  (setq meghanada-server-remote-debug t)
  (setq meghanada-javac-xlint "-Xlint:all,-processing")
  :bind
  (:map meghanada-mode-map
        ("C-S-t" . meghanada-switch-testcase)
        ("M-RET" . meghanada-local-variable)
        ("C-M-." . helm-imenu)
        ; ("M-r" . meghanada-reference)
        ("M-t" . meghanada-typeinfo)
        ("C-z" . hydra-meghanada/body))
  :commands
  (meghanada-mode))

(defhydra hydra-meghanada (:hint nil :exit t)
"
^Edit^                           ^Tast or Task^
^^^^^^-------------------------------------------------------
_b_: meghanada-code-beautify
_f_: meghanada-compile-file      _m_: meghanada-restart
_c_: meghanada-compile-project   _t_: meghanada-run-task
_o_: meghanada-optimize-import   _j_: meghanada-run-junit-test-case
_s_: meghanada-switch-test-case  _J_: meghanada-run-junit-class
_v_: meghanada-local-variable    _R_: meghanada-run-junit-recent
_i_: meghanada-import-all        _r_: meghanada-reference
_g_: magit-status                _T_: meghanada-typeinfo
_l_: helm-ls-git-ls
_q_: exit
"
  ("b" meghanada-code-beautify)
  ("f" meghanada-compile-file)
  ("m" meghanada-restart)

  ("c" meghanada-compile-project)
  ("o" meghanada-optimize-import)
  ("s" meghanada-switch-test-case)
  ("v" meghanada-local-variable)
  ("i" meghanada-import-all)

  ("g" magit-status)
  ("l" helm-ls-git-ls)

  ("t" meghanada-run-task)
  ("T" meghanada-typeinfo)
  ("j" meghanada-run-junit-test-case)
  ("J" meghanada-run-junit-class)
  ("R" meghanada-run-junit-recent)
  ("r" meghanada-reference)

  ("q" exit)
  ("z" nil "leave"))
; ↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥↥




; echo '123456' | pbcopy
; pbpaste
(defun fwrite-region ()
  (interactive)
  (write-region (region-beginning) (region-end) "/tmp/emacsCopyFredJiang.txt")
  ; (write-region "\n"               nil          "/tmp/emacsCopyFredJiang.txt" 'append)
  (shell-command "ecopy fromEmacs"))





; https://github.com/FredJiang/emacs-wttrin.git
; (add-to-list 'load-path "~/.emacs.d/mypackages/emacs-wttrin")
(require 'wttrin)
(setq wttrin-default-cities '("Beijing" "Daoxian" "Yongzhou"))
(setq wttrin-default-accept-language '("Accept-Language" . "zh-CN"))
(defun wttrinOpen ()
  "Display weather information for CITY."
  (wttrin-query "Beijing")
  (delete-other-windows)
  (windmove-left)
  (linum-mode))
(add-hook 'after-init-hook 'wttrinOpen)


; (list-matching-lines-default-context-lines 2)
; auto produced

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-replace nil)
 '(list-matching-lines-default-context-lines 2)
 '(package-selected-packages
   (quote
    (helm-ag paradox eslint-fix realgud hydra windresize window-numbering web-beautify use-package undo-tree smooth-scrolling smex projectile multiple-cursors magit highlight-parentheses highlight-indentation godoctor go-errcheck go-eldoc go-autocomplete flycheck-irony exec-path-from-shell emmet-mode company-irony-c-headers company-irony autodisass-java-bytecode auto-package-update)))
 '(paradox-github-token t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(col-highlight ((t (:background "color-233"))))
 '(hl-line ((t (:background "color-233"))))
 '(lazy-highlight ((t (:background "black" :foreground "white" :underline t))))
 '(neo-dir-link-face ((t (:foreground "cyan"))))
 '(neo-file-link-face ((t (:foreground "white")))))
