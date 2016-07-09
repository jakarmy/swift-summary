
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
 =================================================
 Stored Properties of Constant Structure Instances
 =================================================
 
 If you create an instance of a structure and assign that instance to a constant, you cannot modify the instance’s properties, even if they were declared as variable properties.
 This behavior is due to structures being value types. When an instance of a value type is marked as a constant, so are all of its properties.
 The same is not true for classes, which are reference types. If you assign an instance of a reference type to a constant, you can still change that instance’s variable properties.
 */

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
    
    //These are both stored and computed global variables, or "type" variables. They will apply to all instances of this struct, including their value.
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        // return an Int value here
        get {
            //This is how type vars are accessed, by calling the class
            print(FixedLengthRange.storedTypeProperty)
            return self.computedTypeProperty
        }
        set {
            self.computedTypeProperty = newValue
        }
    }
}

class DataImporter {
    /*
     DataImporter is a class to import data from an external file.
     The class is assumed to take a non-trivial amount of time to initialize.
     */
    var fileName = "data.txt"
    var cont: ViewController = ViewController()
    
    func doSomething() -> Void {
        
    }
    
    // the DataImporter class would provide data importing functionality here
}


class ViewController: UIViewController {
    
    //This is a "Stored Property". It simply provides a value and the ability to set it back.
    var prop = "Hello"
    
    //This is a "Computed Property". Its value is calculated in real-time, and provides getters and setters.
    var someCalculation: Int {
        get {
            return 1 + 1
        }
        set {
            self.someCalculation = newValue
        }
    }
    
    //This property has observers for when the the value will and did set
    var propWithObserver: Int = 0 {
        willSet {
            print(newValue)
        }
        
        didSet {
            print(oldValue)
        }
        //Note that if the didSet sets the value of the property, it doesn't call the setter again
    }
    
    //This is a "Computed Property" with just a getter (read-only).
    var someFixedCalculatedProperty: Double {
        return 3 * 3
    }
    
    //This is a type variable for the class ViewController (it'll apply for all instances). It's weirdly declared with the word "class"
    class var computedTypeProperty: Int {
        // return an Int value here
        get {
            
            return 1 + 1
        }
        set {
            self.computedTypeProperty = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
        // this range represents integer values 0, 1, 2, and 3
        
        rangeOfFourItems.firstValue = 6
        // this will report an error, even though firstValue is a variable property
        
        //Here, importer won't be instantiated until we use it for the first time.
        // lazy var importer = DataImporter()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


