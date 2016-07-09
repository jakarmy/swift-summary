
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

//Swift classes do not inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.

/*
 When you provide a method, property, or subscript override for a subclass, it is sometimes useful
 to use the existing superclass implementation as part of your override. For example, you can refine the
 behavior of that existing implementation, or store a modified value in an existing inherited variable.
 
 Where this is appropriate, you access the superclass version of a method, property, or subscript by using the super prefix:
 
 • An overridden method named someMethod() can call the superclass version of someMethod() by calling super.someMethod() within the overriding method implementation.
 • An overridden property called someProperty can access the superclass version of someProperty as super.someProperty within the overriding getter or setter implementation.
 • An overridden subscript for someIndex can access the superclass version of the same subscript as super[someIndex] from within the overriding subscript implementation.
 */

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

class Bicycle: Vehicle {
    var hasBasket = false
}

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

class Train: Vehicle {
    //Here, we completely changed the base class method implementation for the one defined below.
    override func makeNoise() {
        print("Choo Choo")
    }
}

class Car: Vehicle {
    var gear = 1
    //Here, we are overriding the computed property, adding new behavior
    override var description: String {
        return super.description + " in gear \(gear)"
    }
    
    final func activateAirBags(){
        // - This is the definitive way of activating air bags.
    }
}

class AutomaticCar: Car {
    //This adds a property observer to an inherited property.
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bike = Bicycle()
        bike.hasBasket = true
        bike.description
        
        let tandem = Tandem()
        tandem.currentNumberOfPassengers = 7
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


