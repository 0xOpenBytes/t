import Foundation.FoundationErrors

public extension t {
    /// Emoji Enum used for logging
    struct Emojis {
        /// String used for Tests
        public static var testing = "🧪"
        /// String used for Errors
        public static var error = "❗️"
        /// String used for any Success
        public static var success = "✅"
        /// String used for Failures
        public static var failure = "❌"
        /// String used for any Expectation
        public static var expectation = "🔘"
    }
    
    /// Static logging function used for all logging in `t`
    static var logger: (String) -> Void = { print($0) }
    
    /// Log a message using the `logger`
    static func log(_ message: String) { logger(message) }
    
    /// Log an error using the `logger`
    static func log(
        error: Error
    ) {
        log(error: error, suiteName: nil)
    }
}

// MARK: - Internal Helpers

extension t {
    /// Log function used by the suite when there is an error.
    static func log(
        error: Error,
        suiteName: String?
    ) {
        let messagePrefix = suiteName
            .map { "\(Emojis.error) (\($0)) " } ?? "\(Emojis.error) "
        
        guard let error = error as? TestError else {
            log("\(messagePrefix)\(error.localizedDescription)")
            return
        }
        
        log(
            """
            \(messagePrefix)\(error.description) (
            \tFile: \(error.fileName)
            \tFunction: \(error.functionName)
            \tLine: \(error.lineNumber)
            )
            """
        )
    }
}
