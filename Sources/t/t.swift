/// A simple way to test expectations using functions and errors
public enum t {
    /// Simple Error with a description stating the failure
    public struct TestError: Error {
        public let description: String
        public let lineNumber: Int
        public let functionName: String
        public let fileName: String
    }
}
