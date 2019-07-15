//: Playground - noun: a place where people can play

import UIKit

protocol TypeHolder {
    associatedtype HoldingType
    
    var holdingType: HoldingType { get }
}

class StringHolder: TypeHolder {
    var holdingType: String { return "String" }
}

class IntHolder: TypeHolder {
    var holdingType: Int { return 10 }
}

protocol Foo {
    associatedtype FooTypeHolder: TypeHolder
    
    var typeHolder: FooTypeHolder { get }
}

class FooI: Foo {
    var typeHolder: IntHolder { return IntHolder() }
}

func printHoldingType<T: Foo>(typeHolder: T) -> T.FooTypeHolder.HoldingType {
    return typeHolder.typeHolder.holdingType
}

///----------------------------------------------------------------------

protocol HttpMethodProvidable {
    var httpMethod: String { get }
}

protocol PathAndHttpMethodPorvidalbe: HttpMethodProvidable {
    var path: String { get }
}

struct PathAndHttpMethodPorvidalbeStruct: PathAndHttpMethodPorvidalbe {
    var httpMethod: String { return "httpMethod" }
    var path: String { return "path" }
}

protocol NetworkSessionManager {
    associatedtype EndPoint: HttpMethodProvidable
    
    func execute(_ endPoint: EndPoint)
}

class ImgurNetworkSessionManager {
//    typealias EndPoint = T
//
////    typealias EndPoint = PathAndHttpMethodPorvidalbeStruct

//    func execute(_ endPoint: PathAndHttpMethodPorvidalbe) {
//    }
}

//extension ImgurNetworkSessionManager: NetworkSessionManager {
//    typealias EndPoint = Any
//    
//    func execute(_ endPoint: EndPoint) {
//        
//    }
//}

///----------------------------------------------------------------------

func main() {
}


main()
