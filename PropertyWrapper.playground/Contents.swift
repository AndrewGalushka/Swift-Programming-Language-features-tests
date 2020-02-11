//: Playground - noun: a place where people can play

import UIKit

@propertyWrapper
struct Bindable<Value> where Value: Equatable {
    var wrappedValue: Value {
        didSet {
            if wrappedValue != oldValue {
                
            }
        }
    }
    
    var projectedValue: Bindable<Value> {
        return self
    }
    
    private var notifier = Notifier<AnyObject, Value>()
    
    private func notifyIfDifferent(oldValue: Value, newValue: Value) {
        if oldValue != newValue {
            notifier.notify(aboutChangedValue: newValue)
        }
    }
    
    func bind(to object: AnyObject, valueChangeClosure: @escaping (Value) -> Void) {
        notifier.add(subscriber: object, changeHandler: valueChangeClosure)
    }
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

@propertyWrapper
class ClassWrapped<Value> {
    var wrappedValue: Value
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

class Notifier<Subscriber, Value> where Subscriber: AnyObject {
    typealias NotificationBlock = (Value) -> Void
    private var subscribers = NSMapTable<Subscriber, ClassWrapped<NotificationBlock>>.weakToStrongObjects()

    func add(subscriber: Subscriber, changeHandler: @escaping NotificationBlock) {
        self.subscribers.setObject(ClassWrapped(wrappedValue: changeHandler),
                                   forKey: subscriber)
    }

    func remove(subscriber: Subscriber) {
        self.subscribers.removeObject(forKey: subscriber)
    }

    func notify(aboutChangedValue value: Value) {
        self.subscribers.objectEnumerator()?.forEach {
            ($0 as? ClassWrapped<NotificationBlock>)?.wrappedValue(value)
        }
    }
}

// MARK: - Usage

class TestViewModel {
    @Bindable var uploadState: UploadState = UploadState.initial
    
    enum UploadState {
        case initial
        case inProgress
        case faulted
        case succeeded
    }
}

class TestCase {
    func configure(viewModel: TestViewModel) {
        
        viewModel.$uploadState.bind(to: self) { (newUploadState) in
        }
    }
}

