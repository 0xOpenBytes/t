public extension t {
    /// Assert that the condition is true.
    static func assert(
        _ condition: Bool,
        _ message: String? = nil,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) throws {
        let defaultMessage = "Asserted condition was false (When it should be true)."
        
        guard condition else {
            throw t.error(
                description: message ?? defaultMessage,
                lineNumber: lineNumber,
                functionName: functionName,
                fileName: fileName
            )
        }
    }
    
    /// Assert that the condition is false.
    static func assert(
        notTrue condition: Bool,
        _ message: String? = nil,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) throws {
        let defaultMessage = "Asserted condition was true (When it should be false)."

        guard condition == false else {
            throw t.error(
                description: message ?? defaultMessage,
                lineNumber: lineNumber,
                functionName: functionName,
                fileName: fileName
            )
        }
    }
    
    /// Assert that the first value is equal to the second.
    static func assert<Value: Equatable>(
        _ firstValue: Value,
        isEqualTo secondValue: Value,
        _ message: String? = nil,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) throws {
        let defaultMessage = "The first value (\(firstValue)) was not equal to the second (\(secondValue)) (When it should be equal to)."

        guard firstValue == secondValue else {
            throw t.error(
                description: message ?? defaultMessage,
                lineNumber: lineNumber,
                functionName: functionName,
                fileName: fileName
            )
        }
    }
    
    /// Assert that the first value is not equal to the second.
    static func assert<Value: Equatable>(
        _ firstValue: Value,
        isNotEqualTo secondValue: Value,
        _ message: String? = nil,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) throws {
        let defaultMessage = "The first value (\(firstValue)) was equal to the second (\(secondValue)) (When it should be not equal to)."

        guard firstValue != secondValue else {
            throw t.error(
                description: message ?? defaultMessage,
                lineNumber: lineNumber,
                functionName: functionName,
                fileName: fileName
            )
        }
    }
    
    /// Assert that the value is not nil.
    static func assert<Value>(
        isNotNil value: Value?,
        _ message: String? = nil,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) throws {
        try unwrap(
            value,
            message: message,
            lineNumber: lineNumber,
            functionName: functionName,
            fileName: fileName
        )
    }
    
    /// Assert that the value is nil.
    static func assert<Value>(
        isNil value: Value?,
        _ message: String? = nil,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) throws {
        let defaultMessage = "The value was not nil (When it should be nil)."

        guard value == nil else {
            throw t.error(
                description: message ?? defaultMessage,
                lineNumber: lineNumber,
                functionName: functionName,
                fileName: fileName
            )
        }
    }

    /// Assert that the closure should throw
    static func assertThrows<Value>(
        _ closure: @autoclosure () throws -> Value,
        message: String? = nil,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) throws {
        let defaultMessage = "The closure didn't throw (When it should throw)."

        do {
            let _ = try closure()
            throw t.error(
                description: message ?? defaultMessage,
                lineNumber: lineNumber,
                functionName: functionName,
                fileName: fileName
            )
        } catch {
            return
        }
    }

    /// Assert that the closure should not throw
    static func assertNoThrows<Value>(
        _ closure: @autoclosure () throws -> Value,
        message: String? = nil,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) throws {
        let defaultMessage = "The closure thrww (When it shouldn't throw)."

        do {
            let _ = try closure()
        } catch {
            throw t.error(
                description: message ?? defaultMessage,
                lineNumber: lineNumber,
                functionName: functionName,
                fileName: fileName
            )
        }
    }

    ///
    @discardableResult
    static func unwrap<Value>(
        _ value: Value?,
        message: String? = nil,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) throws -> Value {
        let defaultMessage = "The value was nil (When it should be not nil)."

        guard let value = value else {
            throw t.error(
                description: message ?? defaultMessage,
                lineNumber: lineNumber,
                functionName: functionName,
                fileName: fileName
            )
        }

        return value
    }
}

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)

public extension t {
    /// Assert that the closure should throw
    static func assertThrows<Value>(
        _ closure: @autoclosure () async throws -> Value,
        message: String? = nil,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) async throws {
        let defaultMessage = "The closure didn't throw (When it should throw)."

        do {
            let _ = try await closure()
            throw t.error(
                description: message ?? defaultMessage,
                lineNumber: lineNumber,
                functionName: functionName,
                fileName: fileName
            )
        } catch {
            return
        }
    }

    /// Assert that the closure should not throw
    static func assertNoThrows<Value>(
        _ closure: @autoclosure () async throws -> Value,
        message: String? = nil,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) async throws {
        let defaultMessage = "The closure thrww (When it shouldn't throw)."

        do {
            let _ = try await closure()
        } catch {
            throw t.error(
                description: message ?? defaultMessage,
                lineNumber: lineNumber,
                functionName: functionName,
                fileName: fileName
            )
        }
    }
}

#endif
