//: Playground - noun: a place where people can play

import CoreData
import UIKit
import CoreGraphics

class CoreDataContextObserver {
    // NOTE: Destinition can't be a struct, because ReferenceWritableKeyPath is about reference types only
    // Probably need to add AnyObject constraint to DestinationType to avoid ambiguous compiler errors while using struct as destination type
    // struct is only acceptable as readonly instance
    static func chageValue<SourceType, DestinationType, V>(source: SourceType,
                                                           sourceKeyPath: KeyPath<SourceType, V>,
                                                           destination: DestinationType,
                                                           destinationKeyPath: ReferenceWritableKeyPath<DestinationType, V>)
    {
        
        let sourceValue = source[keyPath: sourceKeyPath]
        destination[keyPath: destinationKeyPath] = sourceValue
    }
}

struct SomeModel {
    var value: Int
    
    init(value: Int = 10) {
        self.value = value
    }
}

class SomeOtherModel {
    var value: Int
    
    init(value: Int = 1) {
        self.value = value
    }
}

func main() {
    let srcNumber = SomeModel(value: 100)
    let destNumber = SomeOtherModel()
    print("before: \(destNumber.value)")
    
    // NOTE: Destinition can't be a struct, because ReferenceWritableKeyPath is about reference types only
    CoreDataContextObserver.chageValue(source: srcNumber,
                                       sourceKeyPath: \SomeModel.value,
                                       destination: destNumber,
                                       destinationKeyPath: \.value)
    print("after: \(destNumber.value)")
    print("Main function END")
}

main()
