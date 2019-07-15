//: Playground - noun: a place where people can play

import UIKit
import AVFoundation

let c1: () -> Void = {}
let c2: () -> Void = {}

typealias VoidClosure = () -> Void

func main() {
    let time = CMTime(value: 1, timescale: 60)
    let zTime = CMTime.zero
    
    print(time)
    print(zTime)
    
    if time == zTime {
        print("YES")
        print(time)
        print(zTime)
    }
}

main()
