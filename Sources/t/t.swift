/// A simple way to test expectations using functions and errors
public enum t {
    // MARK: - Internal Data Types
    
    /// Simple Error with a description stating the failure
    struct TestError: Error {
        let description: String
        let lineNumber: Int
        let functionName: String
        let fileName: String
    }
}
