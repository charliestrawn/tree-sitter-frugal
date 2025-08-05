; Frugal syntax highlighting  
; Based on official Vim syntax and tree-sitter-thrift patterns

; Keywords - namespace and include directives
[
  "include"
  "namespace"
] @include

; Keywords - field qualifiers and modifiers
[
  "const"
  "optional" 
  "required"
  "oneway"
] @keyword

; Keywords - structural definitions
[
  "typedef"
  "enum"
  "struct"
  "exception" 
  "union"
  "service"
  "extends"
  "throws"
] @keyword.function

; Frugal-specific keywords
[
  "scope"
  "prefix"
] @keyword.function

; Note: XSD attributes not implemented in current grammar

; Built-in types
[
  "void"
  "bool"
  "byte" 
  "i8"
  "i16" 
  "i32"
  "i64"
  "double"
  "string"
  "binary"
  "list"
  "set" 
  "map"
] @type.builtin

; Namespace scopes
[
  "*"
  "cpp"
  "java"
  "python"
  "go"
  "js"
  "dart"
] @tag

; User-defined types (capitalized identifiers)
((identifier) @type
  (#match? @type "^[A-Z]"))

; Constants (ALL_CAPS identifiers)
((identifier) @constant
  (#match? @constant "^[A-Z][A-Z0-9_]*$"))

; Function definitions
(function_definition
  (identifier) @function)

; Service names
(service_definition
  "service" @keyword
  (identifier) @type)

; Scope names (Frugal-specific)
(scope_definition
  "scope" @keyword
  (identifier) @type)

; Enum names
(enum_definition
  "enum" @keyword
  (identifier) @type)

; Struct names  
(struct_definition
  "struct" @keyword
  (identifier) @type)

; Exception names
(exception_definition
  "exception" @keyword
  (identifier) @type)

; Union names
(union_definition
  "union" @keyword
  (identifier) @type)

; Typedef names
(typedef_definition
  "typedef" @keyword
  (identifier) @type)

; Const names
(const_definition
  "const" @keyword
  (identifier) @constant)

; Field names
(field (identifier) @field)

; Scope operation names (Frugal-specific)
(scope_operation (identifier) @field)

; Enum field names
(enum_field (identifier) @constant)

; Field IDs
(field_id (integer) @number)

; Function parameters
(field_list (field (identifier) @parameter))

; Annotation names and values
(annotation_list (identifier) @attribute)
(annotation_list (literal_string) @string.special)

; Numbers
(integer) @number
(double) @number

; Strings
(literal_string) @string

; Comments
(comment) @comment

; Note: TODO highlighting would require additional regex matching
; which may not be supported in all tree-sitter implementations

; Operators
[
  "="
  ":"
  ","
  ";"
] @operator

; Punctuation
[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "<"
  ">"
] @punctuation.bracket

; Variables (default for other identifiers)
((identifier) @variable
  (#set! "priority" 95))
