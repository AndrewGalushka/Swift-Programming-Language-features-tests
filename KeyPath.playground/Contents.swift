//: Playground - noun: a place where people can play

import CoreData
import UIKit
import CoreGraphics


/*
 Sources:
 https://docs.swift.org/swift-book/ReferenceManual/Expressions.html
 https://www.swiftbysundell.com/posts/the-power-of-key-paths-in-swift
 
 Inspired by: https://www.swiftbysundell.com/posts/bindable-values-in-swift
*/

class ValueChanger {
    // NOTE: Destinition can't be a struct, because ReferenceWritableKeyPath is about reference types only
    // Probably need to add AnyObject constraint to DestinationType to avoid ambiguous compiler errors while using struct as destination type
    // struct is only acceptable as readonly instance
    static func changeValue<SourceType, DestinationType, V>(source: SourceType,
                                                            sourceKeyPath: KeyPath<SourceType, V>,
                                                            destination: DestinationType,
                                                            destinationKeyPath: ReferenceWritableKeyPath<DestinationType, V>) {
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

extension Array {
    func arrayByRemovingDuplicates<T: Hashable>(identifiedBy keypath: KeyPath<Element, T>) -> [Element] {
        var resultingArray = self
        
        for index in 0..<count {
            var isFirstOccurrence = true
            let identifier = self[index][keyPath: keypath]
            
            resultingArray.removeAll { (element) -> Bool in
                
                if element[keyPath: keypath] == identifier {
                    
                    if isFirstOccurrence {
                        isFirstOccurrence = false
                        return false
                    }
                    
                    return true
                }
                
                return false
            }
        }
        
        return resultingArray
    }
}

struct User {
    let identifier: String
    let name: String
}

func main() {
    let srcNumber = SomeModel(value: 100)
    let destNumber = SomeOtherModel()
    print("before destNumber: \(destNumber.value)")

    // NOTE: Destinition can't be a struct, because ReferenceWritableKeyPath is about reference types only
    ValueChanger.changeValue(source: srcNumber,
                             sourceKeyPath: \SomeModel.value,
                             destination: destNumber,
                             destinationKeyPath: \.value)
    print("after destNumber: \(destNumber.value)")
    
    print("*******************************************************************************************")
    let unfilteredUsersArray: [User] = [.init(identifier: "1", name: "Bob"),
                                        .init(identifier: "1", name: "July"),
                                        .init(identifier: "1", name: "Andrew"),
                                        .init(identifier: "1", name: "Piter"),
                                        .init(identifier: "2", name: "Kate"),
                                        .init(identifier: "2", name: "Maria"),
                                        .init(identifier: "2", name: "Jane"),
                                        .init(identifier: "randid", name: "Ragnar"),
                                        .init(identifier: "randid2", name: "Jame")]
    
    print("array before filtering by user ID: \(unfilteredUsersArray.map { ($0.identifier, $0.name) })")
    let filteredUsersArray = unfilteredUsersArray.arrayByRemovingDuplicates(identifiedBy: \.identifier)
    print("array after filtering by user ID: \(filteredUsersArray.map { ($0.identifier, $0.name) })")
    
    print("*******************************************************************************************")
    print("Main function END")
}

main()
