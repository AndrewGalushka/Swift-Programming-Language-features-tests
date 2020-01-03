//: Playground - noun: a place where people can play

import UIKit

@propertyWrapper
struct Atomic<Value> {
    private let queue = DispatchQueue(label: "com.andrewgaluska.atomic")
    private var value: Value

    init(wrappedValue: Value) {
        self.value = wrappedValue
    }
    
    var wrappedValue: Value {
        get {
            return queue.sync { value }
        }
        set {
            queue.sync { value = newValue }
        }
    }
    
    var projectedValue: String {
        return "projectedValue"
    }
}

struct Foo: ExpressibleByIntegerLiteral {
    @Atomic var value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    init(integerLiteral value: Int) {
        self.value = value
    }
}

// MARK: - Main -

func main() {
    let foo = Foo(value: 10)
    print(foo.$value)
    
}

main()
