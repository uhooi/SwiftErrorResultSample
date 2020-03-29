//: [Previous](@previous)

struct E: Error {}

//: ## Success

func fuga() throws -> Int {
    return 1
}

let fugaR = Result { try fuga() }
    .mapError { $0 as! E }

switch fugaR {
case .success(let i):
    print("success: \(i)")
case .failure(let e):
    print("failure: \(e)")
}

//: ## Failure

func hoge() throws -> Int {
    throw E()
}

let hogeR = Result { try hoge() }
    .mapError { $0 as! E }

switch hogeR {
case .success(let i):
    print("success: \(i)")
case .failure(let e):
    print("failure: \(e)")
}

//: [Next](@next)
