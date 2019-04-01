import XCTest
@testable import SharedModels

final class SharedModelsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SharedModels().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
