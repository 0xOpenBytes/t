public extension t {
    /// Create a test suite with multiple steps, expectations, and asserts.
    @discardableResult
    static func suite(
        named name: String? = nil,
        _ test: () throws -> Void
    ) -> Bool {
        let suiteNamed = name.map { "Suite \($0)" } ?? "Suite"
        log("🧪 Testing \(suiteNamed)")
        do {
            try test()
            log("✅ \(suiteNamed) Passed!")
            return true
        } catch {
            log(error: error, suiteName: suiteNamed)
            log("❌ \(suiteNamed) Failed!")
            return false
        }
    }
    
    /// Create an expectation with one or multiple assertions.
    static func expect(
        _ description: String? = nil,
        expectation: () throws -> Void
    ) throws {
        _ = description.map { log("🔘 Expecting \($0)") }
        try expectation()
    }
}
