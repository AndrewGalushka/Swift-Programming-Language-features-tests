//: Playground - noun: a place where people can play

import UIKit

class SingleReceiverBinding<Value> {
    typealias Value = Value
    typealias Update = (oldValue: Value, newValue: Value)
    typealias UpdatingClosure = (_ v: Update) -> Void
    
    private typealias Subscription = (reciever: WeakObjectBox<AnyObject>, update: UpdatingClosure)
    private var subscription: Subscription?
    
    var value: Value {
        didSet {
            let oldValue = oldValue
            let newValue = value
            
            DispatchQueue.main.async {
                self.notify(aboutUpdate: (oldValue: oldValue, newValue: newValue))
            }
        }
    }
    
    init(initialValue value: Value) {
        self.value = value
    }
    
    func bind(to reciever: AnyObject, updateHandler: @escaping UpdatingClosure) {
        DispatchQueue.main.async {
            self.register(Subscription(reciever: WeakObjectBox<AnyObject>(value: reciever),
                                       update: updateHandler))
        }
    }
    
    func notify(aboutUpdate: Update) {
        DispatchQueue.main.async {
            
            if let subscription = self.subscription {
                
                if subscription.reciever.isEpty {
                    self.subscription = nil
                } else {
                    self.subscription?.update(aboutUpdate)
                }
            }
        }
    }
}

private extension SingleReceiverBinding {
    private func register(_ subscription: Subscription) {
        self.subscription = subscription
    }
    
    private class WeakObjectBox<T: AnyObject> {
        weak var value: T?
        
        init(value: T) {
            self.value = value
        }
        
        var isEpty: Bool {
            return value == nil
        }
    }
}


func main() {
    print("Main function End")
}

main()
