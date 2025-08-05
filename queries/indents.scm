; Frugal indentation rules
; Based on tree-sitter-thrift patterns with Frugal-specific additions

; Indent all definitions
(definition) @indent

; Indent struct, enum, service, and scope bodies
(struct_body) @indent
(enum_body) @indent
(service_body) @indent
(scope_body) @indent  ; Frugal-specific

; Align function parameters within parentheses
((field_list (field)) @aligned_indent
  (#set! "delimiter" "()"))

; Align annotation parameters within parentheses  
((annotation_list) @aligned_indent
  (#set! "delimiter" "()"))

; End indentation at closing braces
"}" @indent_end

; Mark braces and parentheses as branching points
[ "{" "}" ] @branch
[ "(" ")" ] @branch

; Auto-indent for errors and comments
[
  (ERROR)
  (comment)
] @auto