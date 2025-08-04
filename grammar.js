/**
 * @file Frugal grammar for tree-sitter
 * @author Charlie Strawn
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
  name: "frugal",

  extras: $ => [
    /\s/,
    $.comment,
  ],

  rules: {
    document: $ => repeat(choice(
      $.header,
      $.definition,
    )),

    // Headers
    header: $ => choice(
      $.include,
      $.namespace,
    ),

    include: $ => seq(
      'include',
      $.literal_string,
    ),

    namespace: $ => seq(
      'namespace',
      $.namespace_scope,
      $.identifier,
    ),

    namespace_scope: $ => choice(
      '*',
      'cpp',
      'java',
      'python',
      'go',
      'js',
      'dart',
    ),

    // Basic definitions (start simple)
    definition: $ => choice(
      $.const_definition,
      $.typedef_definition,
      $.enum_definition,
      $.struct_definition,
      $.service_definition,
      $.scope_definition, // Frugal-specific
    ),

    const_definition: $ => seq(
      'const',
      $.field_type,
      $.identifier,
      '=',
      $.const_value,
      optional($.list_separator),
    ),

    typedef_definition: $ => seq(
      'typedef',
      $.field_type,
      $.identifier,
      optional($.annotation),
      optional($.list_separator),
    ),

    enum_definition: $ => seq(
      'enum',
      $.identifier,
      optional($.annotation),
      '{',
      optional($.enum_body),
      '}',
      optional($.annotation),
    ),

    enum_body: $ => repeat1($.enum_field),

    enum_field: $ => seq(
      $.identifier,
      optional(seq('=', $.integer)),
      optional($.annotation),
      optional($.list_separator),
    ),

    struct_definition: $ => seq(
      'struct',
      $.identifier,
      optional($.annotation),
      '{',
      optional($.struct_body),
      '}',
      optional($.annotation),
    ),

    struct_body: $ => repeat1($.field),

    field: $ => seq(
      optional($.field_id),
      optional($.field_req),
      $.field_type,
      $.identifier,
      optional(seq('=', $.const_value)),
      optional($.annotation),
      optional($.list_separator),
    ),

    field_id: $ => seq($.integer, ':'),

    field_req: $ => choice('required', 'optional'),

    service_definition: $ => seq(
      'service',
      $.identifier,
      optional(seq('extends', $.identifier)),
      optional($.annotation),
      '{',
      optional($.service_body),
      '}',
      optional($.annotation),
    ),

    service_body: $ => repeat1($.function_definition),

    function_definition: $ => seq(
      optional('oneway'),
      $.function_type,
      $.identifier,
      '(',
      optional($.field_list),
      ')',
      optional(seq('throws', '(', $.field_list, ')')),
      optional($.annotation),
      optional($.list_separator),
    ),

    function_type: $ => choice($.field_type, 'void'),

    field_list: $ => repeat1($.field),

    // Frugal-specific scope definition
    scope_definition: $ => seq(
      'scope',
      $.identifier,
      optional($.scope_prefix),
      '{',
      optional($.scope_body),
      '}',
    ),

    scope_prefix: $ => seq(
      'prefix',
      $.literal_string,
    ),

    scope_body: $ => repeat1($.scope_operation),

    scope_operation: $ => seq(
      $.identifier,
      ':',
      $.field_type,
      optional($.annotation),
      optional($.list_separator),
    ),

    // Types
    field_type: $ => choice(
      $.base_type,
      $.container_type,
      $.identifier, // user-defined type
    ),

    base_type: $ => choice(
      'bool',
      'byte',
      'i8',
      'i16',
      'i32',
      'i64',
      'double',
      'string',
      'binary',
    ),

    container_type: $ => choice(
      $.list_type,
      $.set_type,
      $.map_type,
    ),

    list_type: $ => seq('list', '<', $.field_type, '>'),
    set_type: $ => seq('set', '<', $.field_type, '>'),
    map_type: $ => seq('map', '<', $.field_type, ',', $.field_type, '>'),

    // Literals and values
    const_value: $ => choice(
      $.integer,
      $.double,
      $.literal_string,
      $.identifier,
      $.const_list,
      $.const_map,
    ),

    const_list: $ => seq('[', optional($.const_list_contents), ']'),
    const_list_contents: $ => repeat1(seq($.const_value, optional($.list_separator))),

    const_map: $ => seq('{', optional($.const_map_contents), '}'),
    const_map_contents: $ => repeat1(seq($.const_value, ':', $.const_value, optional($.list_separator))),

    // Annotations
    annotation: $ => seq('(', optional($.annotation_list), ')'),
    annotation_list: $ => repeat1(seq($.identifier, optional(seq('=', $.literal_string)), optional($.list_separator))),

    // Tokens
    identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,
    integer: $ => /-?[0-9]+/,
    double: $ => /-?[0-9]*\.[0-9]+([eE][+-]?[0-9]+)?/,
    literal_string: $ => choice(
      seq('"', repeat(choice(/[^"\\]/, /\\./)), '"'),
      seq("'", repeat(choice(/[^'\\]/, /\\./)), "'"),
    ),

    list_separator: $ => choice(',', ';'),

    comment: $ => choice(
      seq('//', /.*/),
      seq('/*', /[^*]*\*+([^/*][^*]*\*+)*/, '/'),
      seq('#', /.*/),
    ),
  }
});
