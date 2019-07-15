//: Playground - noun: a place where people can play

import UIKit

let operationQueue = OperationQueue()
operationQueue.maxConcurrentOperationCount = 5


for globalIterator in 0...10000 {
    operationQueue.addOperation {
        let semapthore = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2.0)
            semapthore.signal()
        }
        
        semapthore.wait()
        print("\(globalIterator) iteration Reliazed")
    }
}
