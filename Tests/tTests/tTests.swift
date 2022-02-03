import XCTest
@testable import t

final class tTests: XCTestCase {
    func testExample() throws {
        XCTAssert(
            // Create Test Suite
            t.suite {
                // Add an expectation that asserting true is true and that 2 is equal to 2
                try t.expect {
                    try t.assert(true)
                    try t.assert(2, isEqualTo: 2)
                }
                
                // Add an assertion that asserting false is not true
                try t.assert(notTrue: false)
                
                // Add an assertion that "Hello" is not equal to "World"
                try t.assert("Hello", isNotEqualTo: "World")
                
                // Log a message
                t.log("📣 Test Log Message")
                
                // Log a t.error
                t.log(error: t.error(description: "Mock Error"))
                
                // Log any error
                struct SomeError: Error { }
                t.log(error: SomeError())
                
                // Add an assertion to check if a value is nil
                let someValue: String? = nil
                try t.assert(isNil: someValue)
                
                // Add an assertion to check if a value is not nil
                let someOtherValue: String? = "💠"
                try t.assert(isNotNil: someOtherValue)
            }
        )
    }
    
    func testSuiteFailure() throws {
        XCTAssertFalse(
            t.suite(named: "Expected Failure") {
                try t.assert(false)
            }
        )
    }
    
    func testExpect() throws {
        XCTAssertNoThrow(
            try t.expect("true is true and that 2 is equal to 2") {
                try t.assert(true)
                try t.assert(2, isEqualTo: 2)
            }
        )
    }
    
    func testAssert() throws {
        XCTAssertNoThrow(
            try t.assert(true)
        )
    }
    
    func testAssert_failure() throws {
        XCTAssertThrowsError(
            try t.assert(false)
        )
    }
    
    func testAssertNotTrue_failure() throws {
        XCTAssertThrowsError(
            try t.assert(notTrue: true)
        )
    }
    
    func testAssertIsEqualTo_failure() throws {
        XCTAssertThrowsError(
            try t.assert("Hello", isEqualTo: "World")
        )
    }
    
    func testAssertIsNotEqualTo_failure() throws {
        XCTAssertThrowsError(
            try t.assert("Hello", isNotEqualTo: "Hello")
        )
    }
    
    func testAssertIsNil_failure() throws {
        XCTAssertThrowsError(
            try t.expect {
                let someValue: String? = "Hello"
                try t.assert(isNil: someValue)
            }
        )
    }
    
    func testAssertIsNotNil_failure() throws {
        XCTAssertThrowsError(
            try t.expect {
                let someValue: String? = nil
                try t.assert(isNotNil: someValue)
            }
        )
    }
}

/*
 
 // Log a message
 t.log("📣 Test Log Message")
 
 // Add an assertion to check if a value is nil
 let someValue: String? = nil
 try t.assert(isNil: someValue)
 
 // Add an assertion to check if a value is not nil
 let someOtherValue: String? = "💠"
 try t.assert(isNotNil: someOtherValue)
 */
