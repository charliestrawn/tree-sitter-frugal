import XCTest
import SwiftTreeSitter
import TreeSitterFrugal

final class TreeSitterFrugalTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_frugal())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Frugal grammar")
    }
}
