
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
 Reference counting only applies to instances of classes. Structures and enumerations are value types,
 not reference types, and are not stored and passed by reference.
 */

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

// At this point, these references are nil.
var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")

//At this point 3 strong references of "John Appleseed" are being stored.
reference2 = reference1
reference3 = reference1

//John is still alive
reference1 = nil
reference2 = nil

//John is dead by now.
reference3 = nil


/*
 ===============================================
 Strong Reference Cycles Between Class Instances
 ===============================================
 */

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

class Tenant : Person {
    var apartment: Apartment?
}

var john: Tenant?
var unit4A: Apartment?

john = Tenant(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

//Here's where the reference cycle is created.
john!.apartment = unit4A
unit4A!.tenant = john

// The variables are still references from inside the properties. This creates the reference cycle,
// and therefore, a memory leak.
// A simple way around this would be to manually set the apartment and tenant properties to nil, and then set the outside references to nil.
john = nil
unit4A = nil


/*
 =========================================================
 Resolving Strong Reference Cycles Between Class Instances
 =========================================================
 
 Weak and unowned references enable one instance in a reference cycle to refer to the other instance
 without keeping a strong hold on it. The instances can then refer to each other without creating a strong reference cycle.
 
 Use a weak reference whenever it is valid for that reference to become nil at some point during its lifetime.
 Conversely, use an unowned reference when you know that the reference will never be nil once it has been set during initialization.
 */

// Weak References
/*
 Use a weak reference to avoid reference cycles whenever it is possible for that reference to have “no value”
 at some point in its life. If the reference will always have a value, use an unowned reference instead,
 as described in Unowned References. In the Apartment example above, it is appropriate for an apartment to be able to
 have “no tenant” at some point in its lifetime, and so a weak reference is an appropriate way to break the reference cycle in this case.
 
 NOTE
 
 Weak references must be declared as variables, to indicate that their value can change at runtime. A weak reference cannot be declared as a constant.
 */


//Unowned References

/*
 Like weak references, an unowned reference does not keep a strong hold on the instance it refers to. Unlike a weak reference,
 however, an unowned reference is assumed to always have a value. Because of this, an unowned reference is always defined as a
 nonoptional type. You indicate an unowned reference by placing the unowned keyword before a property or variable declaration.
 
 Because an unowned reference is nonoptional, you don’t need to unwrap the unowned reference each time it is used.
 An unowned reference can always be accessed directly. However, ARC cannot set the reference to nil when the instance it refers
 to is deallocated, because variables of a nonoptional type cannot be set to nil.
 
 NOTE
 
 If you try to access an unowned reference after the instance that it references is deallocated, you will trigger a runtime error.
 Use unowned references only when you are sure that the reference will always refer to an instance.
 
 Note also that Swift guarantees your app will crash if you try to access an unowned reference after the instance it references is deallocated.
 You will never encounter unexpected behavior in this situation. Your app will always crash reliably, although you should, of course, prevent it from doing so.
 
 */

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var mike: Customer?
mike = Customer(name: "Mike Appleseed")
mike!.card = CreditCard(number: 1234_5678_9012_3456, customer: mike!)
mike = nil


/*
 ===============================================================
 Unowned References and Implicitly Unwrapped Optional Properties
 ===============================================================
 
 However, there is a third scenario, in which both properties should always have a value, and neither property should ever be
 nil once initialization is complete. In this scenario, it is useful to combine an unowned property on one class with an implicitly
 unwrapped optional property on the other class.
 
 This enables both properties to be accessed directly (without optional unwrapping) once initialization is complete, while still
 avoiding a reference cycle. This section shows you how to set up such a relationship.
 */


class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

/*
 The initializer for City is called from within the initializer for Country. However, the initializer for Country cannot pass
 self to the City initializer until a new Country instance is fully initialized, as described in Two-Phase Initialization.
 
 To cope with this requirement, you declare the capitalCity property of Country as an implicitly unwrapped optional property,
 indicated by the exclamation mark at the end of its type annotation (City!). This means that the capitalCity property has a
 default value of nil, like any other optional, but can be accessed without the need to unwrap its value as described in Implicitly Unwrapped Optionals.
 
 Because capitalCity has a default nil value, a new Country instance is considered fully initialized as soon as the Country instance
 sets its name property within its initializer. This means that the Country initializer can start to reference and pass around the
 implicit self property as soon as the name property is set. The Country initializer can therefore pass self as one of the parameters
 for the City initializer when the Country initializer is setting its own capitalCity property.
 */



/*
 ====================================
 Strong Reference Cycles for Closures
 ====================================
 
 A strong reference cycle can also occur if you assign a closure to a property of a class instance, and the body of that
 closure captures the instance. This capture might occur because the closure’s body accesses a property of the instance,
 such as self.someProperty, or because the closure calls a method on the instance, such as self.someMethod(). In either case,
 these accesses cause the closure to “capture” self, creating a strong reference cycle.
 
 Swift provides an elegant solution to this problem, known as a closure capture list.
 */

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: (Void) -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

/*
 A capture list defines the rules to use when capturing one or more reference types within the closure’s body.
 As with strong reference cycles between two class instances, you declare each captured reference to be a weak or unowned reference rather than a strong reference.
 */

class HTMLElement2 {
    
    let name: String
    let text: String?
    
    lazy var asHTML: (Void) -> String = {
        [unowned self] in //Closure List
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

