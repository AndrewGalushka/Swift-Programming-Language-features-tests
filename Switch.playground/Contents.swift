//: Playground - noun: a place where people can play

import UIKit

func isVideoSizeValid(size: CGSize) -> Bool {
    
    let isWidthValid = { (width: CGFloat) -> Bool in return width >= 1024 }
    
    switch size {
    case (let size) where isWidthValid(size.width):
        print("case (let size) where size.width > 1024:")
        return false
    case (let size) where size.height >= 720:
        print("case (let size) where size.height > 720:")
        return false
    case (let size) where size.height / size.width == 3/4:
        print("case (let size) where size.width / size.height == 3/4:")
        return false
    default:
        print("default:")
        return true
    }
}

func main() {
    isVideoSizeValid(size: CGSize(width: 4, height: 3))
    print("Main function end")
}

main()
