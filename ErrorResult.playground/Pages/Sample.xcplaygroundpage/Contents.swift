//: [Previous](@previous)

enum MyError: Error {
    case foo(_ message: String)
    case bar(_ message: String)
}

func myFunc(isSuccess: Bool) throws -> String {
    if isSuccess {
        return "Success!!"
    } else {
        throw MyError.foo("Foo")
    }
}

//: ## Before

//: ### Success

do {
    let beforeResult = try myFunc(isSuccess: true)
    print("Success: \(beforeResult)")
} catch MyError.foo(let message) {
    print("MyError.foo: \(message)")
} catch MyError.bar(let message) {
    print("MyError.bar: \(message)")
} catch {
    // !!!: 絶対に入らないけど必要
}

//: ### Failure

do {
    let beforeResult = try myFunc(isSuccess: false)
    print("Success: \(beforeResult)")
} catch MyError.foo(let message) {
    print("MyError.foo: \(message)")
} catch MyError.bar(let message) {
    print("MyError.bar: \(message)")
} catch {
    // !!!: 絶対に入らないけど必要
}

//: ## After

//: ### Success

let successResult = Result { try myFunc(isSuccess: true) }
    .mapError { $0 as! MyError }

switch successResult {
case .success(let string):
    print("Success: \(string)")
case .failure(let error):
    switch error {
    case .foo(let message):
        print("MyError.foo: \(message)")
    case .bar(let message):
        print("MyError.bar: \(message)")
    }
}

//: ### Failure

let failureResult = Result { try myFunc(isSuccess: false) }
    .mapError { $0 as! MyError }

switch failureResult {
case .success(let string):
    print("success: \(string)")
case .failure(let error):
    switch error {
    case .foo(let message):
        print("MyError.foo: \(message)")
    case .bar(let message):
        print("MyError.bar: \(message)")
    }
}

//: [Next](@next)
