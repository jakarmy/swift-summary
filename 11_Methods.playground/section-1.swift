
// |=------------------------------------------------------=|
//  Copyright (c) 2016 Juan Antonio Karmy.
//  Licensed under MIT License
//
//  See https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ for Swift Language Reference
//
//  See Juan Antonio Karmy - http://karmy.co | http://twitter.com/jkarmy
//
// |=------------------------------------------------------=|


import UIKit

/*
 There are instance methods and type (class) methods
 */

struct Point {
    var x = 0.0, y = 0.0
    static var xy = 0.0
    
    //This is a mutating method. Allows for modifying value types
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        //Here, the properties will be replaced with new values, thanks to the mutating prefix
        x += deltaX
        y += deltaY
        
        //Reassigning self is also possible because of the mutating prefix. Note that this is only possible for value types
        self = Point(x: x + deltaX, y: y + deltaY)
    }
    
    //This is a type method.
    static func unlockLevel(level: Double) {
        if xy > level { xy = level }
    }
}

class ViewController: UIViewController {
    
    var count = 0
    
    //This is an instance method
    func increment() {
        count += 1
    }
    
    //This is a class method.
    class func someTypeMethod() {
        print("Class Method")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


