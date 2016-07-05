
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


struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

/*
 For the struct, a memberwise initializer is provided. This means that stored properties don't
 necessarily need to have an initial value. A default initializer is created for all of them.
 */
struct Other {
    var temp: Double
    var otherProp: Int = 10
}

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

/*
 In this case, the second initializer performs delegation, which is
 calling another initializer within the struct. This is only valid for
 value types, and not classes!
 */
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

/*
 ==================================
 */

/*
 For a class, every stored property must have an initial value, or have a value assigned to it inside the initializer.
 This reference image explains the relationship between designated initializers and convenience initializers.
 https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Art/initializerDelegation01_2x.png
 • Rule 1
 A designated initializer must call a designated initializer from its immediate superclass.
 
 • Rule 2
 A convenience initializer must call another initializer from the same class.
 
 • Rule 3
 A convenience initializer must ultimately call a designated initializer.
 
 A simple way to remember this is:
 
 - Designated initializers must always delegate up.
 - Convenience initializers must always delegate across.
 
 
 • Phase 1
 
 - A designated or convenience initializer is called on a class.
 - Memory for a new instance of that class is allocated. The memory is not yet initialized.
 - A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
 - The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
 - This continues up the class inheritance chain until the top of the chain is reached.
 - Once the top of the chain is reached, and the final class in the chain has ensured that all of its store
 properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
 
 • Phase 2
 
 - Working back down from the top of the chain, each designated initializer in the chain has the option to
 customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
 - Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.
 
 Also, keep in mind that:
 • Rule 1
 If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
 
 • Rule 2
 If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as
 per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.
 
 NOTE
 A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2.
 
 
 */

class Human {
    var gender: String
    init(){
        self.gender = "Female"
    }
}

class Person: Human {
    var name: String
    init(fullName name: String){
        //Phase 1: Initialize class-defined properties and call the superclass initializer.
        self.name = name
        super.init()
        //-------
        
        //Phase 2: Further customization of local and inherited properties.
        self.gender = "Male"
        //-------
    }
    convenience init(partialName name: String){
        //Phase 1: Call designated initializer
        let newName = "\(name) Karmy"
        self.init(fullName: newName)
        //-------
        
        //Phase 2: Access to self and properties
        self.name = "John Karmy"
        //-------
        
    }
}

/*
 ==================================
 */

/*
 Failable initializers allow us to return nil during initialization in case there was a problem.
 The object being initalized is treated as an optional.
 You can also define a failable initializer that returns an implicitly unwrapped optional instance by writing init!
 */

// For enums, nil can be returned at any point of initalizations

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

// For class instances, nil can only be returned after initalizing all properties.

class Product {
    let name: String!
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}

/*
 ==================================
 */

/*
 You can pre-initialize properties by running code inside a closure. Since the execution happens before all other properties are initialized,
 you can't access other properties nor call self inside the closure.
 */

struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }() //Note that these parenthesis indicate that you want to run the closure immediately.
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}

/*
 ==================================
 */

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        let bodyTemperature = Celsius(37.0)
        print((bodyTemperature.temperatureInCelsius))
        
        let person = Person(fullName: "John")
        print(person.name)
        
        let other = Other(temp: 20, otherProp: 10)
        print(other.otherProp)
        
        if let product = Product(name: "Apple"){
            print("Product is not nil. Names \(product.name)")
        }
        
    }
}

