import Foundation.FoundationErrors

public extension t {
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
        let messagePrefix = suiteName.map { "❗️ (\($0)) " } ?? "❗️ "
        
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
