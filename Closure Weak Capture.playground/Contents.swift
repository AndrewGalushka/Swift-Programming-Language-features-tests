//: Playground - noun: a place where people can play

import UIKit

class Foo {
    var holder: Holder?
    
    deinit {
        print("Foo deinit")
    }
}

class Holder {
    let closure: (() -> Void)?
    
    init(closure: (() -> Void)?) {
        self.closure = closure
    }
    
    deinit {
        print("Holder deinit")
    }
}

func main() {
    let foo = Foo()
    let holder = Holder(closure: { [weak foo] in print(foo) })
    foo.holder = holder
}

main()
