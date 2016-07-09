
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
 Classes and structures in Swift have many things in common. Both can:
 
 • Define properties to store values
 • Define methods to provide functionality
 • Define subscripts to provide access to their values using subscript syntax
 • Define initializers to set up their initial state
 • Be extended to expand their functionality beyond a default implementation
 • Conform to protocols to provide standard functionality of a certain kind
 
 Classes have additional capabilities that structures do not:
 
 • Inheritance enables one class to inherit the characteristics of another.
 • Type casting enables you to check and interpret the type of a class instance at runtime.
 • Deinitializers enable an instance of a class to free up any resources it has assigned.
 • Reference counting allows more than one reference to a class instance.
 
 NOTE
 
 Structures are always copied when they are passed around in your code, and do not use reference counting.
 The same applies to Enums
 
 
 
 
 Choosing Between Classes and Structures
 
 You can use both classes and structures to define custom data types to use as the building blocks of your program’s code.
 
 However, structure instances are always passed by value, and class instances are always passed by reference. This means that they are suited to different kinds of tasks. As you consider the data constructs and functionality that you need for a project, decide whether each data construct should be defined as a class or as a structure.
 
 As a general guideline, consider creating a structure when one or more of these conditions apply:
 
 • The structure’s primary purpose is to encapsulate a few relatively simple data values.
 • It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
 • Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
 • The structure does not need to inherit properties or behavior from another existing type.
 
 Examples of good candidates for structures include:
 
 • The size of a geometric shape, perhaps encapsulating a width property and a height property, both of type Double.
 • A way to refer to ranges within a series, perhaps encapsulating a start property and a length property, both of type Int.
 • A point in a 3D coordinate system, perhaps encapsulating x, y and z properties, each of type Double.
 In all other cases, define a class, and create instances of that class to be managed and passed by reference. In practice, this means that most custom data constructs should be classes, not structures.
 
 
 Assignment and Copy Behavior for Strings, Arrays, and Dictionaries
 
 Swift’s String, Array, and Dictionary types are implemented as structures. This means that strings, arrays, and dictionaries are copied when they are assigned to a new constant or variable, or when they are passed to a function or method.
 
 This behavior is different from NSString, NSArray, and NSDictionary in Foundation, which are implemented as classes, not structures. NSString, NSArray, and NSDictionary instances are always assigned and passed around as a reference to an existing instance, rather than as a copy.
 */

struct Resolution {
    var width = 0
    var height = 0
}

class ViewController: UIViewController {
    
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


