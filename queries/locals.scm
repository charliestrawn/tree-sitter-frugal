; Frugal local scope and definition rules
; Based on tree-sitter-thrift patterns with Frugal-specific additions

; Scopes
[
  (document)
  (definition)
  (struct_body)
  (enum_body) 
  (service_body)
  (scope_body)        ; Frugal-specific
] @local.scope

; References
(identifier) @local.reference

; Definitions - Constants
(const_definition (identifier) @local.definition.constant)

; Definitions - Type definitions
(typedef_definition (identifier) @local.definition.type)

; Definitions - Enums
(enum_definition (identifier) @local.definition.enum)
(enum_field (identifier) @local.definition.constant)

; Definitions - Structs
(struct_definition (identifier) @local.definition.type)

; Definitions - Exceptions
(exception_definition (identifier) @local.definition.type)

; Definitions - Unions
(union_definition (identifier) @local.definition.type)

; Definitions - Services
(service_definition (identifier) @local.definition.type)

; Definitions - Scopes (Frugal-specific)
(scope_definition (identifier) @local.definition.type)

; Definitions - Fields
(field (identifier) @local.definition.field)

; Definitions - Scope operations (Frugal-specific)
(scope_operation (identifier) @local.definition.field)

; Definitions - Function names
(function_definition (identifier) @local.definition.function)

; Definitions - Parameters
(field_list (field (identifier)) @local.definition.parameter)

; Definitions - Namespaces
(namespace (identifier) @local.definition.namespace)

; Definitions - Annotations
(annotation_list (identifier) @local.definition.attribute)