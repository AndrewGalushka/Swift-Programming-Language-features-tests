//: Playground - noun: a place where people can play

import CoreData
import UIKit
import CoreGraphics

class CoreDataContextObserver {
    static func observe<SourceType, DestinitionType, V>(source: SourceType,
                                                        sourceKeyPath: KeyPath<SourceType, V>,
                                                        destinition: DestinitionType,
                                                        destinitionKeyPath: ReferenceWritableKeyPath<DestinitionType, V>)
    {
        
        let sourceValue = source[keyPath: sourceKeyPath]
        destinition[keyPath: destinitionKeyPath] = sourceValue
    }
}

class SomeModel {
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
    var srcNumber = SomeModel(value: 100)
    var destNumber = SomeOtherModel()
    print("before: \(destNumber.value)")
    CoreDataContextObserver.observe(source: srcNumber,
                                    sourceKeyPath: \SomeModel.value,
                                    destinition: destNumber,
                                    destinitionKeyPath: \.value)
    print("after: \(destNumber.value)")
    print("Main function END")
}

main()
