public extension t {
    /// Create a test suite with multiple steps, expectations, and asserts.
    @discardableResult
    static func suite(
        named name: String? = nil,
        _ test: () throws -> Void
    ) -> Bool {
        let suiteNamed = name.map { "Suite \($0)" } ?? "Suite"
        log("\(Emojis.testing) Testing \(suiteNamed)")
        do {
            try test()
            log("\(Emojis.success) \(suiteNamed) Passed!")
            return true
        } catch {
            log(error: error, suiteName: suiteNamed)
            log("\(Emojis.failure) \(suiteNamed) Failed!")
            return false
        }
    }
    
    /// Create an expectation with one or multiple assertions.
    static func expect(
        _ description: String? = nil,
        expectation: () throws -> Void
    ) throws {
        _ = description.map { log("\(Emojis.expectation) Expecting \($0)") }
        try expectation()
    }
    
    /// Create a tested value that had the ability to throw an error.
    static func tested<Output>(
        _ description: String,
        _ test: () throws -> Output
    ) throws -> Output {
        log("\(Emojis.testing) Testing \(description)")
        
        do {
            let value = try test()
            log("\(Emojis.success) Test \(description) Passed!")
            return value
        } catch {
            log(error: error)
            log("\(Emojis.failure) Test \(description) Failed!")
            throw error
        }
    }
    
    /// Create a tested value that had the ability to throw an error.
    static func tested<Output>(
        _ test: () throws -> Output
    ) throws -> Output { try test() }
}
