//: Playground - noun: a place where people can play

import UIKit

/*
 Source: https://www.hackingwithswift.com/articles/77/whats-new-in-swift-4-2
 */

@dynamicMemberLookup
enum JSON {
    case intValue(Int)
    case stringValue(String)
    case arrayValue(Array<JSON>)
    case dictionaryValue(Dictionary<String, JSON>)
    
    var stringValue: String? {
        if case .stringValue(let str) = self {
            return str
        }
        return nil
    }
    
    subscript(index: Int) -> JSON? {
        if case .arrayValue(let arr) = self {
            return index < arr.count ? arr[index] : nil
        }
        return nil
    }
    
    subscript(key: String) -> JSON? {
        if case .dictionaryValue(let dict) = self {
            return dict[key]
        }
        return nil
    }
    
    subscript(dynamicMember member: String) -> JSON? {
        if case .dictionaryValue(let dict) = self {
            return dict[member]
        }
        return nil
    }
}

// Usage: json[0]?.name?.first?.stringValue

func main() {
}

main()
