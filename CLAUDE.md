# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Tree-sitter grammar for the Frugal language. Frugal is a superset of Apache Thrift that adds pub/sub capabilities and other advanced features while maintaining Thrift compatibility. Tree-sitter is an incremental parsing library that generates parsers for source code languages. This repository contains:

- Core grammar definition in `grammar.js` (currently minimal with placeholder rules)
- C scanner implementation in `src/scanner.c` (minimal external scanner)
- Multi-language bindings for Node.js, Rust, Python, Go, Swift, and C
- Query files for syntax highlighting in `queries/`

### Frugal Language Features
Frugal extends Thrift with:
- **Scopes**: Pub/sub interface definitions (`scope Events { EventCreated: Event }`)
- **Topic Prefixes**: Variable substitution in topics for dynamic routing
- **Enhanced Annotations**: Special comment syntax `/**@ ... */` for documentation
- **Request Features**: Headers, multiplexing, interceptors, per-request timeouts
- **Thrift Compatibility**: Valid Thrift code should be valid Frugal code

## Development Commands

### Building and Testing
- **Generate parser**: `tree-sitter generate` (generates parser from grammar.js)
- **Build WASM**: `tree-sitter build --wasm` (builds WebAssembly version)
- **Test grammar**: `tree-sitter test` or `make test`
- **Run playground**: `tree-sitter playground` (interactive testing)

### Node.js Specific
- **Install dependencies**: `npm install`
- **Run tests**: `npm test` (runs Node.js binding tests)
- **Start playground**: `npm start` (builds WASM and starts playground)

### Language Bindings
- **Rust**: `cargo build`, `cargo test`
- **Python**: Standard setuptools build via `pyproject.toml`
- **C**: `make` (builds static/shared libraries)
- **Go**: Standard Go build process

## Architecture

### Core Components
- **`grammar.js`**: Main grammar definition file using Tree-sitter DSL
- **`src/scanner.c`**: External scanner for complex lexical analysis (currently minimal)
- **`src/parser.c`**: Generated parser (auto-generated, don't edit directly)
- **`queries/highlights.scm`**: Syntax highlighting queries

### Binding Structure
Each language binding follows Tree-sitter conventions:
- **Node.js** (`bindings/node/`): Native addon using node-gyp
- **Rust** (`bindings/rust/`): Standard Cargo crate with build script
- **Python** (`bindings/python/`): Setuptools package with C extension
- **Go** (`bindings/go/`): CGO bindings with tests
- **Swift** (`bindings/swift/`): Swift package with C interop

### Grammar Development Workflow
1. Edit `grammar.js` to define language rules (base on tree-sitter-thrift + Frugal extensions)
2. Run `tree-sitter generate` to create parser
3. Test with `tree-sitter test` using corpus files
4. Update `queries/highlights.scm` for syntax highlighting
5. Build and test language-specific bindings

### Implementation Notes
- **Base Grammar**: Start with tree-sitter-thrift grammar as foundation
- **Frugal Extensions**: Add scope definitions, topic prefixes, enhanced annotations
- **Reference Grammar**: Frugal PEG grammar at `charliestrawn/frugal/compiler/parser/grammar.peg`
- **Key Constructs**: Include, namespace, const, enum, typedef, struct, exception, union, service, scope

## File Types and Scope
- File extension: `.frugal`
- Tree-sitter scope: `source.frugal`
- Injection regex: `^frugal$`

## Current State
The grammar is in initial development state with placeholder rules. The external scanner is minimal and may need removal if not required for the final grammar.

## Key Resources
- **tree-sitter-thrift**: https://github.com/tree-sitter-grammars/tree-sitter-thrift (base implementation)
- **Frugal Source**: https://github.com/charliestrawn/frugal/tree/master/compiler/parser (reference grammar)
- **Frugal Language**: Superset of Thrift with pub/sub scopes and enhanced features