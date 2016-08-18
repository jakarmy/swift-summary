
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
 =================
 Generic Functions
 =================
 */

// Basic example

func swapTwoValues<T>( _ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"

/*
 The swapTwoValues(_:_:) function defined above is inspired by a generic function called swap,
 which is part of the Swift standard library, and is automatically made available for you to use in your apps.
 If you need the behavior of the swapTwoValues(_:_:) function in your own code, you can use Swift’s
 existing swap(_:_:) function rather than providing your own implementation.
 */

/*You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.*/

/*
 ======================
 Naming Type Parameters
 ======================
 */

/*
 In most cases, type parameters have descriptive names, such as Key and Value in Dictionary<Key, Value>
 and Element in Array<Element>, which tells the reader about the relationship between the type parameter
 and the generic type or function it’s used in. However, when there isn’t a meaningful relationship between them,
 it’s traditional to name them using single letters such as T, U, and V, such as T in the swapTwoValues(_:_:) function above.
 */

/*
 NOTE
 
 Always give type parameters upper camel case names (such as T and MyTypeParameter) to indicate
 that they are a placeholder for a type, not a value.
 */


/*
 =============
 Generic Types
 =============
 */

/*
 Swift enables you to define your own generic types. These are custom classes, structures,
 and enumerations that can work with any type, in a similar way to Array and Dictionary.
 */

struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

/*
 Note how the generic version of Stack is essentially the same as the non-generic version,
 but with a type parameter called Element instead of an actual type of Int.
 This type parameter is written within a pair of angle brackets (<Element>) immediately after the structure’s name.
 
 Element defines a placeholder name for “some type Element” to be provided later on.
 This future type can be referred to as “Element” anywhere within the structure’s definition.
 */

var stackOfStrings = Stack<String>()
stackOfStrings.push(item: "uno")
stackOfStrings.push(item: "dos")
stackOfStrings.push(item: "tres")
stackOfStrings.push(item: "cuatro")
// the stack now contains 4 strings


/*
 ========================
 Extending a Generic Type
 ========================
 */

/*
 When you extend a generic type, you do not provide a type parameter list as part of the extension’s definition.
 Instead, the type parameter list from the original type definition is available within the body of the extension,
 and the original type parameter names are used to refer to the type parameters from the original definition.
 */

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

/*
 Note that this extension does not define a type parameter list.
 Instead, the Stack type’s existing type parameter name, Element,
 is used within the extension to indicate the optional type of the topItem computed property.
 */


/*
 ================
 Type Constraints
 ================
 */

protocol SomeProtocol {
    
}

class SomeClass {
    
}

func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
}

/*
 The hypothetical function above has two type parameters. The first type parameter, T,
 has a type constraint that requires T to be a subclass of SomeClass.
 The second type parameter, U, has a type constraint that requires U to conform to the protocol SomeProtocol.
 */

// Example
func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

/*
 ================
 Associated Types
 ================
 */

/*
 The Container protocol needs a way to refer to the type of the elements that a container will hold,
 without knowing what that type is for a specific container.
 */

protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct OtherStack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(item: Element) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

/*
 Thanks to Swift’s type inference, you don’t actually need to declare a concrete ItemType of Int as part of the definition of IntStack.
 Because IntStack conforms to all of the requirements of the Container protocol, Swift can infer the appropriate ItemType to use,
 simply by looking at the type of the append(_:) method’s item parameter and the return type of the subscript.
 Indeed, if you delete the typealias ItemType = Int line from the code above,
 everything still works, because it is clear what type should be used for ItemType.
 */

// You can extend an existing type to add conformance to a protocol.

extension Array: Container {}

/*
 ================
 Associated Types
 ================
 */

func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, _ anotherContainer: C2) -> Bool {
    
    // check that both containers contain the same number of items
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    // check each pair of items to see if they are equivalent
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    // all items match, so return true
    return true
    
}

/*
 It can also be useful to define requirements for associated types.
 You do this by defining where clauses as part of a type parameter list.
 */
