# t

*Quickly test expectations*

## What is `t`?

`t` is a simple testing framework using closures and errors. You have the ability to create a `suite` that has multiple steps, expectations, and asserts. Expectations can be used to `expect` one or multiple assertions.

## Where can `t` be used?

`t` can be used to test quickly inside a function to make sure something is working as expected. `t` can also be used in unit test if wanted.

## Examples

### t.suite
```swift
t.suite {
    // Add an expectation that asserting true is true and that 2 is equal to 2
    try t.expect {
        try t.assert(true)
        try t.assert(2, isEqualTo: 2)
    }
    
    // Add an assertion that asserting false is not true
    try t.assert(notTrue: false)
    
    // Add an assertion that "Hello" is not equal to "World"
    try t.assert("Hello", isNotEqualTo: "World")
    
    // Log a message
    t.log("📣 Test Log Message")
    
    // Log a t.error
    t.log(error: t.error(description: "Mock Error"))
    
    // Log any error
    struct SomeError: Error { }
    t.log(error: SomeError())
    
    // Add an assertion to check if a value is nil
    let someValue: String? = nil
    try t.assert(isNil: someValue)
    
    // Add an assertion to check if a value is not nil
    let someOtherValue: String? = "💠"
    try t.assert(isNotNil: someOtherValue)
}
```

### t.expect
```swift
try t.expect {
    let someValue: String? = "Hello"
    try t.assert(isNil: someValue)
}
```

### t.assert
```swift
try t.assert("Hello", isEqualTo: "World")
```

### t.log
```swift
t.log("📣 Test Log Message")
```

### XCTest

#### Assert suite is true
```swift
XCTAssert(
    t.suite {
        try t.assert(true)
    }
)
```

#### Assert expectation is true
```swift
XCTAssertNoThrow(
    try t.expect("true is true and that 2 is equal to 2") {
        try t.assert(true)
        try t.assert(2, isEqualTo: 2)
    }
)
```

#### Assert is false
```swift
XCTAssertThrowsError(
    try t.assert(false)
)
```
