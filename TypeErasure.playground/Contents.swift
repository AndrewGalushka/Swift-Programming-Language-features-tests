//: Playground - noun: a place where people can play

import UIKit

protocol HTTPURLRequestable {
    associatedtype MappingResult
    
    func map() -> MappingResult
}

protocol SessionManageable {
    associatedtype Request: HTTPURLRequestable
    
    func execute(_ request: Request) -> Request.MappingResult
    func cancel(_ request: Request)
}

class AnySessionManageable<T: SessionManageable>: SessionManageable {

    private let t: T
    
    init(_ sessionManageable: T) {
        self.t = sessionManageable
    }
    
    func execute(_ request: T.Request) -> T.Request.MappingResult {
        return t.execute(request)
    }
    
    func cancel(_ request: T.Request) {
        t.cancel(request)
    }
}

protocol Printable {
    associatedtype InternalType
    
    func print()
}

class IntPrinter: Printable {
    typealias InternalType = Int
    
    func print() {
        Swift.print(10)
    }
}

class StringPrinter: Printable {
    typealias InternalType = String
    
    func print() {
        Swift.print("String")
    }
}

class AnyPrintable: Printable {
    typealias InternalType = Any
    private let _print: () -> Void
    
    init<U>(_ u: U) where U: Printable {
        _print = u.print
    }
    
    func print() {
        _print()
    }
}

func printAll(_ array: [AnyPrintable]) {
    array.forEach { $0.print() }
}

//class AnyCachable<T>: Cachable {
//    private let _decode: (_ data: Data) -> T?
//    private let _encode: () -> Data?
//    init<U: Cachable>(_ cachable: U) where U.CacheType == T {
//        _decode = cachable.decode
//        _encode = cachable.encode
//    }
//    func decode(_ data: Data) -> T? {
//        return _decode(data)
//    }
//    func encode() -> Data? {
//        return _encode()
//    }
//}




///----------------------------------------------------------------------

func main() {
    printAll([AnyPrintable(StringPrinter()), AnyPrintable(IntPrinter())])
}


main()
