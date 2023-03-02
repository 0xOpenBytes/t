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

        let value: Output

        do {
            value = try test()
            log("\(Emojis.success) Test \(description) Passed!")
        } catch {
            log(error: error)
            log("\(Emojis.failure) Test \(description) Failed!")
            throw error
        }

        return value
    }
    
    /// Create a tested value that had the ability to throw an error.
    static func tested<Output>(
        _ test: () throws -> Output
    ) throws -> Output { try test() }
}

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)

public extension t {
    /// Create a test suite with multiple steps, expectations, and asserts.
    @discardableResult
    static func suite(
        named name: String? = nil,
        _ test: () async throws -> Void
    ) async -> Bool {
        var result: Error?

        do {
            try await test()
        } catch {
            result = error
        }

        return suite(named: name) {
            if let result = result {
                throw result
            }
        }
    }

    /// Create an expectation with one or multiple assertions.
    static func expect(
        _ description: String? = nil,
        expectation: () async throws -> Void
    ) async throws {
        var result: Error?

        do {
            try await expectation()
        } catch {
            result = error
        }

        return try expect(description) {
            if let result = result {
                throw result
            }
        }
    }

    /// Create a tested value that had the ability to throw an error.
    static func tested<Output>(
        _ description: String,
        _ test: () async throws -> Output
    ) async throws -> Output {
        var output: Output?
        var result: Error?

        do {
            output = try await test()
        } catch {
            result = error
        }

        return try tested(description) {
            if let result = result {
                throw result
            }

            return try unwrap(output)
        }
    }

    /// Create a tested value that had the ability to throw an error.
    static func tested<Output>(
        _ test: () async throws -> Output
    ) async throws -> Output { try await test() }
}

#endif
