; Frugal syntax highlighting  
; Based on official Vim syntax and tree-sitter-thrift patterns
; Updated for Neovim compatibility with specific capture groups

; Keywords - import and namespace directives  
[
  "include"
  "namespace"
] @keyword.import

; Keywords - field qualifiers and modifiers
[
  "const"
  "optional" 
  "required"
  "oneway"
] @keyword.modifier

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
] @keyword.type

; Frugal-specific keywords
[
  "scope"
  "prefix"
] @keyword.type

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
] @module

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
  "service" @keyword.type
  (identifier) @type)

; Scope names (Frugal-specific)
(scope_definition
  "scope" @keyword.type
  (identifier) @type)

; Enum names
(enum_definition
  "enum" @keyword.type
  (identifier) @type)

; Struct names  
(struct_definition
  "struct" @keyword.type
  (identifier) @type)

; Exception names
(exception_definition
  "exception" @keyword.type
  (identifier) @type)

; Union names
(union_definition
  "union" @keyword.type
  (identifier) @type)

; Typedef names
(typedef_definition
  "typedef" @keyword.type
  (identifier) @type)

; Const names
(const_definition
  "const" @keyword.modifier
  (identifier) @constant)

; Field names
(field (identifier) @property)

; Scope operation names (Frugal-specific)
(scope_operation (identifier) @property)

; Enum field names
(enum_field (identifier) @constant)

; Field IDs
(field_id (integer) @number)

; Function parameters
(field_list (field (identifier) @variable.parameter))

; Annotation names and values
(annotation_list (identifier) @attribute)
(annotation_list (literal_string) @string.documentation)

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
