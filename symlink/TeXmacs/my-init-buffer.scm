(kbd-map
  ("s h return" (make 'shell-code))
  ("c p p return" (make 'cpp-code))
  ("p y return" (make 'python-code))
  ("p y tab" (make-session "scheme" "defaule"))
  ("M-p" (clipboard-paste-import "verbatim" "primary")))


;────────────────────────────────────────────;
; Keyboard shortcuts only valid in text-mode ;
;────────────────────────────────────────────;

(kbd-map
  (:mode in-text?)
  ;("w" (insert "Welcome in RMLL 2005"))
  ("e q u ." (begin (insert "Eq. (") (make 'reference) (insert "equ:")))
  ("s c m tab" (make-session "scheme" "default"))
  ("g r a p h tab" (make-session "graph" "default")))


;────────────────────────────────────────────;
; Keyboard shortcuts only valid in math-mode ;
;────────────────────────────────────────────;

(kbd-map
  (:mode in-math?)
  ("g r a d ." (insert "<nabla>"))
  ("d i v ."   (insert "<nabla><cdot>"))
  ("r o t ."   (insert "<nabla><times>"))
  ("C-1" (numbered-toggle (focus-tree))))



;───────────────────────;
; vim like key bindings ;
;───────────────────────;
(kbd-map
  ("A-h" (kbd-left))
  ("A-j" (kbd-down))
  ("A-k" (kbd-up))
  ("A-l" (kbd-right))
  ("C-h" (kbd-select kbd-left))
  ("C-j" (kbd-select kbd-down))
  ("C-k" (kbd-select kbd-up))
  ("C-l" (kbd-select kbd-right))
  ("A-p" (traverse-previous))
  ("A-n" (traverse-next))
  ("home home" (go-start))
  ("end end" (go-end))
  ("C-1" (make 'math)))
