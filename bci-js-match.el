;;;###autoload
(defun bci-seq-into-pairs (lst &optional keep-last)
  "Partition LST into pairs.

For odd lists, omit the last element, unless KEEP-LAST is
non-nil."
  (unless keep-last
    (if (oddp (length lst))
        (setq lst (butlast lst))))
  (seq-partition lst 2))

(bci-seq-into-pairs '(1 2 4 5 6))

;;;###autoload
(defun bci-get-string-matches (str regexp)
  "Emulate semantics of JavaScript's 'match' method for strings
to Elisp.

When REGEXP matches against string STR, a list is returned whose
first element is the entire match, and whose subsequent elements
are the match groups."
  (with-temp-buffer
    (insert str)
    (beginning-of-buffer)
    (when (re-search-forward regexp nil t)
      (mapcar (lambda (pair)
                (apply #'buffer-substring-no-properties pair))
              (bci-seq-into-pairs (match-data 'integers))))))

(provide 'bci-js-match)
