(with-eval-after-load "ox"
  (require 'ox-latex)
  (setq org-src-fontify-natively t)
  (setq org-highlight-latex-and-related '(latex script entities))
  (setq TeX-master t)
  ;; http://qiita.com/kawabata@github/items/1b56ec8284942ff2646b
  (defun remove-org-newlines-at-cjk-text (&optional _mode)
    "先頭が '*', '#', '|' でなく、改行の前後が日本の文字の場合はその改行を除去する。"
    (interactive)
    (goto-char (point-min))
    (while (re-search-forward "^\\([^|#*\n].+\\)\\(.\\)\n *\\(.\\)" nil t)
      (if (and (> (string-to-char (match-string 2)) #x2000)
               (> (string-to-char (match-string 3)) #x2000))
          (replace-match "\\1\\2\\3"))
      (goto-char (point-at-bol))))
  (add-hook 'org-export-before-processing-hook 'remove-org-newlines-at-cjk-text)

  (setq org-latex-default-packages-alist
        '(("" "xltxtra" nil)
          ("" "zxjatype" nil)
          ("ipaex" "zxjafont" nil)
          ("normalem" "ulem" nil)
          ("" "listings" nil)
          ))

  (setq org-latex-classes nil)

  (add-to-list 'org-latex-classes
               '("bxjsarticle"
                 "\\documentclass{bxjsarticle}
[DEFAULT-PACKAGES]
\\usepackage{color, graphicx}
\\usepackage{amsmath, amssymb, amsthm}
\\usepackage{hyperref}
\\usepackage{fancyvrb}
\\fvset{fontsize=\\footnotesize,frame=single,numbers=none}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ))

  (setq org-latex-pdf-process '("latexmk -C %f" "latexmk -f -xelatex %f"))
  (setq org-latex-default-class "bxjsarticle")

;;
;; http://stackoverflow.com/questions/9311538/how-to-make-non-breaking-spaces-ties-in-org-mode-that-exports-properly-to-late
;;
  (setq org-entities-user
        '(("space" "~" nil "&nbsp;" " " " " " ")))
  (fset 'my-space "\\space{}")
  (global-set-key (kbd "C-~") 'my-space)


;; listings
  (setq org-latex-listings 'listings)
  (setq org-latex-listings-options
        '(("frame" "single")
          ("basicstyle" "\\footnotesize\\ttfamily")
          ("showspaces" "false")
          ("showstringspaces" "false")
          ("numberstyle" "\\tiny")))

;;http://qiita.com/kawabata@github/items/1b56ec8284942ff2646b
;; "verbatim" → "Verbatim" 置換
  (defun my-org-latex-filter-verbatim (text backend _info)
    (when (eq backend 'latex)
      (replace-regexp-in-string
       "^\\\\\\(begin\\|end\\){verbatim}$"
       "\\\\\\1{Verbatim}" text
       )))
  (add-to-list 'org-export-filter-final-output-functions
               'my-org-latex-filter-verbatim)

;; fig / tab
  (defun my-org-latex-filter-figtab (text backend _info)
    (when (eq backend 'latex)
      (replace-regexp-in-string
       "^\\\\begin{\\(figure\\|table\\)}$"
       "\\\\begin{\\1}[htb]" text
       )))
  (add-to-list 'org-export-filter-final-output-functions
               'my-org-latex-filter-figtab)

;; beamer
  (require 'ox-beamer)
  (setq org-beamer-frame-default-options "t")
  (defun my-beamer-structure (contents backend info)
    (when (eq backend 'beamer)
      (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\structure" contents)))
  (add-to-list 'org-export-filter-italic-functions 'my-beamer-structure)

;;
  ;; (require 'ox-md)
  (require 'org-ref)
(global-set-key (kbd "C-c C-]") 'org-ref)
;; org-ref-insert-bibliography-link (C-c ])
;; org2blog
(setq load-path (cons "~/Dropbox/lisp/org2blog/" load-path))
(require 'org2blog-autoloads)
(setq org2blog/wp-blog-alist
      '(("miyazakikenji"
         :url "https://miyazakikenji.wordpress.com/xmlrpc.php"
         :username "kenjimyzk"
         :default-title "Hello World"
         :default-categories ("computer")
         :tags-as-categories ("spacemacs"))
        ))
)
(advice-add 'url-http-create-request :override
            'url-http-create-request-debug)
(defun url-http-create-request-debug (&optional ref-url)
  "Create an HTTP request for <code>url-http-target-url', referred to by REF-URL."
  (let* ((extra-headers)
         (request nil)
         (no-cache (cdr-safe (assoc "Pragma" url-http-extra-headers)))
         (using-proxy url-http-proxy)
         (proxy-auth (if (or (cdr-safe (assoc "Proxy-Authorization"
                                              url-http-extra-headers))
                             (not using-proxy))
                         nil
                       (let ((url-basic-auth-storage
                              'url-http-proxy-basic-auth-storage))
                         (url-get-authentication url-http-proxy nil 'any nil))))
         (real-fname (url-filename url-http-target-url))
         (host (url-http--encode-string (url-host url-http-target-url)))
         (auth (if (cdr-safe (assoc "Authorization" url-http-extra-headers))
                   nil
                 (url-get-authentication (or
                                          (and (boundp 'proxy-info)
                                               proxy-info)
                                          url-http-target-url) nil 'any nil))))
    (if (equal "" real-fname)
        (setq real-fname "/"))
    (setq no-cache (and no-cache (string-match "no-cache" no-cache)))
    (if auth
        (setq auth (concat "Authorization: " auth "\r\n")))
    (if proxy-auth
        (setq proxy-auth (concat "Proxy-Authorization: " proxy-auth "\r\n")))
 
    ;; Protection against stupid values in the referrer
    (if (and ref-url (stringp ref-url) (or (string= ref-url "file:nil")
                                           (string= ref-url "")))
        (setq ref-url nil))
 
    ;; We do not want to expose the referrer if the user is paranoid.
    (if (or (memq url-privacy-level '(low high paranoid))
            (and (listp url-privacy-level)
                 (memq 'lastloc url-privacy-level)))
        (setq ref-url nil))
 
    ;; url-http-extra-headers contains an assoc-list of
    ;; header/value pairs that we need to put into the request.
    (setq extra-headers (mapconcat
                         (lambda (x)
                           (concat (car x) ": " (cdr x)))
                         url-http-extra-headers "\r\n"))
    (if (not (equal extra-headers ""))
        (setq extra-headers (concat extra-headers "\r\n")))
 
    ;; This was done with a call to </code>format'.  Concatenating parts has
    ;; the advantage of keeping the parts of each header together and
    ;; allows us to elide null lines directly, at the cost of making
    ;; the layout less clear.
    (setq request
          (concat
             ;; The request
             (or url-http-method "GET") " "
             (url-http--encode-string
              (if using-proxy (url-recreate-url url-http-target-url) real-fname))
             " HTTP/" url-http-version "\r\n"
             ;; Version of MIME we speak
             "MIME-Version: 1.0\r\n"
             ;; (maybe) Try to keep the connection open
             "Connection: " (if (or using-proxy
                                    (not url-http-attempt-keepalives))
                                "close" "keep-alive") "\r\n"
                                ;; HTTP extensions we support
             (if url-extensions-header
                 (format
                  "Extension: %s\r\n" url-extensions-header))
             ;; Who we want to talk to
             (if (/= (url-port url-http-target-url)
                     (url-scheme-get-property
                      (url-type url-http-target-url) 'default-port))
                 (format
                  "Host: %s:%d\r\n" host (url-port url-http-target-url))
               (format "Host: %s\r\n" host))
             ;; Who its from
             (if url-personal-mail-address
                 (concat
                  "From: " url-personal-mail-address "\r\n"))
             ;; Encodings we understand
             (if (or url-mime-encoding-string
                     ;; MS-Windows loads zlib dynamically, so recheck
                     ;; in case they made it available since
                     ;; initialization in url-vars.el.
                     (and (eq 'system-type 'windows-nt)
                          (fboundp 'zlib-available-p)
                          (zlib-available-p)
                          (setq url-mime-encoding-string "gzip")))
                 (concat
                  "Accept-encoding: " url-mime-encoding-string "\r\n"))
             (if url-mime-charset-string
                 (concat
                  "Accept-charset: "
                  (url-http--encode-string url-mime-charset-string)
                  "\r\n"))
             ;; Languages we understand
             (if url-mime-language-string
                 (concat
                  "Accept-language: " url-mime-language-string "\r\n"))
             ;; Types we understand
             "Accept: " (or url-mime-accept-string "*/*") "\r\n"
             ;; User agent
             (url-http-user-agent-string)
             ;; Proxy Authorization
             proxy-auth
             ;; Authorization
             auth
             ;; Cookies
             (when (url-use-cookies url-http-target-url)
               (url-http--encode-string
                (url-cookie-generate-header-lines
                 host real-fname
                 (equal "https" (url-type url-http-target-url)))))
             ;; If-modified-since
             (if (and (not no-cache)
                      (member url-http-method '("GET" nil)))
                 (let ((tm (url-is-cached url-http-target-url)))
                   (if tm
                       (concat "If-modified-since: "
                               (url-get-normalized-date tm) "\r\n"))))
             ;; Whence we came
             (if ref-url (concat
                          "Referer: " ref-url "\r\n"))
             extra-headers
             ;; Length of data
             (if url-http-data
                 (concat
                  "Content-length: " (number-to-string
                                      (length url-http-data))
                  "\r\n"))
             ;; End request
             "\r\n"
             ;; Any data
             url-http-data))
    ;; Bug#23750
    ;;(unless (= (string-bytes request)
    ;;           (length request))
    ;;  (message "   text byte %d vs %d length" (string-bytes request) (length request)))
      ;;(message "===============================")
      ;;(error "Multibyte text in HTTP request: %s" request))
    (url-http-debug "Request is: \n%s" request)
    request))
;;
;;
;;(with-eval-after-load "ess"
;;(require 'ob-julia)
;;
;; org-babel
;;
(with-eval-after-load "ob"
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (R . t)
   (python . t)
;;  (julia . t)
   (latex . t)
   (emacs-lisp . t)
   ))
(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
)

