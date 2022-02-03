public extension t {
    /// Error factory that takes a description and will capture the lineNumber, functionName, and fileName where the error was created.
    static func error(
        description: String,
        lineNumber: Int = #line,
        functionName: String = #function,
        fileName: String = #file
    ) -> Error {
        tError(
            description: description,
            lineNumber: lineNumber,
            functionName: functionName,
            fileName: fileName
        )
    }
}
