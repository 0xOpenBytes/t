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

                try t.assertNoThrows { try t.assert(true) }

                try t.assertThrows { try t.assert(false) }

                try t.assertThrows(t.assertNoThrows(t.assert(false)))

                try t.assertNoThrows(t.assertThrows(t.assert(true)))

                // Add an assertion that "Hello" is not equal to "World"
                try t.assert("Hello", isNotEqualTo: "World")

                // Log a message
                t.log("📣 Test Log Message")

                // Log a t.error
                t.log(error: t.error(description: "Mock Error"))

                // Log any error
                struct SomeError: LocalizedError { }
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
    
    func testTestedValue() throws {
        XCTAssertNoThrow(
            try t.assert(
                t.tested("that a String will be returned.") { "Hello World!" },
                isEqualTo: "Hello World!"
            )
        )
    }
    
    func testTestedValueThrow() throws {
        XCTAssertThrowsError(
            try t.tested("that there will be an error thrown.") { throw t.error(description: "Some Error") }
        )
    }
    
    func testTestedValueNoDescription() throws {
        XCTAssert(
            t.suite {
                let value: Int = try t.tested {
                    let int = Int.random(in: 1 ... 100)
                    
                    try t.assert(int >= 1)
                    
                    return int
                }
                var sum = 5
                
                sum += value
                
                try t.assert(sum, isNotEqualTo: value)
            }
        )
    }
}

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)

extension tTests {
    func testAsyncExample() async throws {
        // Create Test Suite
        let result = await t.suite {
            // Add an expectation that asserting true is true and that 2 is equal to 2
            try t.expect {
                try t.assert(true)
                try t.assert(2, isEqualTo: 2)
            }

            let _ = try await t.tested("async tested") {
                let value = Double.pi
                try t.assert(notTrue: value < 3)
                try await t.assertNoThrows { try t.assert(true) }
                return value
            }

            try await t.expect {
                try await t.assertNoThrows { try t.assert(true) }

                try await t.assertThrows { try t.assert(false) }

                try await t.assertThrows(await t.assertNoThrows(t.assert(false)))

                try await t.assertNoThrows(await t.assertThrows(t.assert(true)))
            }

            // Add an assertion that "Hello" is not equal to "World"
            try t.assert("Hello", isNotEqualTo: "World")

            // Log a message
            t.log("📣 Test Log Message")

            // Log a t.error
            t.log(error: t.error(description: "Mock Error"))

            // Log any error
            struct SomeError: LocalizedError { }
            t.log(error: SomeError())

            // Add an assertion to check if a value is nil
            let someValue: String? = nil
            try t.assert(isNil: someValue)

            // Add an assertion to check if a value is not nil
            let someOtherValue: String? = "💠"
            try t.assert(isNotNil: someOtherValue)
        }

        XCTAssert(result)
    }
}

#endif
