package tree_sitter_frugal_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_frugal "github.com/charliestrawn/tree-sitter-frugal/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_frugal.Language())
	if language == nil {
		t.Errorf("Error loading Frugal grammar")
	}
}
