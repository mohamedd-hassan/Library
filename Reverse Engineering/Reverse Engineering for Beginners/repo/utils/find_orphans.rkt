#lang racket

(define all-languages (list "CN" "DE" "EN" "ES" "FR" "IT" "JA" "NL" "PL" "PTBR" "RU" "TH" "TR"))

(define path (vector-ref (current-command-line-arguments) 0))
(define first-file (vector-ref (current-command-line-arguments) 1))

; "\LL{xxx}" -> "xxx" if lang="LL"
(define (expand-lang-macro s lang)
  (if
   (string-prefix? s (string-append "\\" lang "{"))
   (let [(a (regexp-match (regexp (string-append "\\\\" lang "{(.*)}.*")) s))]
     (if a (second a) s))
   s))

; "\LL{xxx}" -> "" if lang="LL"
(define (remove-lang-macro s lang)
  (if
   (string-prefix? s (string-append "\\" lang "{"))
   ""
   s))

; it evaluates to a chain: (remove-lang-macro (remove-lang-macro input "RU") "FR") etc
(define (remove-unneded-languages lst omitted-languages)
  (foldl
   (lambda (x y) (remove-lang-macro y x))
   lst omitted-languages))

(define (add-tex-ext-if-absent fname)
  (if (string-suffix? fname ".tex")
      fname
      (string-append fname ".tex")))

(define (parse-newcommand s)
  (let [(tmp (regexp-match #rx"\\\\(re)?newcommand{(.*)}{(.*)}" s))]
    (if tmp
        (list
         (list-ref tmp 2)
         (list-ref tmp 3))
        #f)))

(define tbl (make-hash))

(define (str-replace-if-contains s from to)
  (if (string-contains? s from)
      (string-replace s from to)
      s))

(define (expand-macro-if-needed s)
  (let ([keys (hash-keys tbl)])
    (for ([k keys])
      (set! s (str-replace-if-contains s k (hash-ref tbl k))))
    s))

(define (handle-newcommand-if-needed s)
  (let [(parsed-newcommand (parse-newcommand s))]
    (when parsed-newcommand
      (hash-set! tbl (first parsed-newcommand) (second parsed-newcommand))
      )))

(define listings (mutable-set))

(define (handle-lstinputlisting-if-needed s)
  (let ([m (regexp-match #rx"\\\\lstinputlisting(\\[.*\\])?{(.*)}.*" s)])
    (when m
      (set-add! listings (string-append path (expand-macro-if-needed (third m))))
      )))

(define pix (mutable-set))

(define (handle-gfx-if-needed s)
  (let ([m (regexp-match #rx"(\\\\frame{)?\\\\(my)?includegraphics(Small)?(\\[.*\\])?{(.*)}.*" s)])
    (when m
      (set-add! pix (string-trim (string-append path (expand-macro-if-needed (list-ref m 5))) "}")))))

(define RepoURLs (mutable-set))

(define (remove-substring s sub)
  (string-replace s sub ""))

(define (remove-substrings s lst)
  (foldl
   (lambda (x y) (remove-substring y x))
   s lst))
  
(define (handle-RepoURL-if-needed s)
  (when (string-contains? s "\\Repo")
    (define RepoURL (hash-ref tbl "\\RepoURL")) ; usually "https://beginners.re/current-tree/"
    (for/list ([a (regexp-match* #rx"\\\\(url|href){\\\\Repo([A-Za-z])+/(.*?)}" s)])
      (set-add! RepoURLs
                (string-append path
                               (string-trim
                                (string-trim
                                 (remove-substrings
                                  (expand-macro-if-needed (expand-macro-if-needed a)) ; twice: to be sure
                                  (list
                                   (string-append "\\url{" RepoURL)
                                   (string-append "\\href{" RepoURL)))
                                 "}")
                                "/")
                               )))))

(define files-processed (mutable-set))

(define (parse-input s)
  (second (regexp-match #rx"\\\\input{(.*)}.*" s)))

(define (remove-unicode-BOM s)
  (if
   (string-prefix? s "\uFEFF")
   (substring s 1)
   s))

(define lines 0)

(define (process fname lang)
  (define omitted-languages (remove lang all-languages))
  (define full-fname (add-tex-ext-if-absent (string-append path fname)))
  (set-add! files-processed full-fname)
  (define in-port (open-input-file full-fname))
  (for ([line (in-lines in-port)])
    (set! lines (add1 lines))
    (define line2 (remove-unicode-BOM line))
    (when (not (string-prefix? line2 "%")) ; skip comments
      (define l (remove-unneded-languages (expand-lang-macro line2 lang) omitted-languages))
      (handle-newcommand-if-needed l)
      (handle-lstinputlisting-if-needed l)
      (handle-gfx-if-needed l)
      (handle-RepoURL-if-needed l)
      (when
          (string-prefix? l "\\input{")
        (process (expand-macro-if-needed (parse-input l)) lang)
        )))
  (close-input-port in-port))

#|
(define all-tex-files-in-path
  (map path->string
       (find-files (lambda (x) (string-suffix? (path->string x) ".tex")) path)))
|#

(define all-files-in-path
  (map path->string
       (find-files (lambda (x)
                     (and
                      (file-exists? x)
                      (not (string-contains? (path->string x) "/."))
                      (not (string-contains? (path->string x) ".ni"))
                      )
                     ) path)))

(process first-file "EN")
(process first-file "RU")
(process first-file "ES")
(process first-file "FR")
(process first-file "DE")
(process first-file "IT")
(process first-file "JA")
(process first-file "PL")
(process first-file "CN")
(process first-file "NL")
(process first-file "TR")
(process first-file "PTBR")

(define result (sort
                (set->list (set-subtract
                            (list->set all-files-in-path)
                            files-processed
                            listings
                            pix
                            RepoURLs
                            ))
                string<?))

(displayln "orphaned files (not included in any .tex file)")
(for ([i result])
  (displayln i))

(displayln "lines total in all processed text files:")
lines
