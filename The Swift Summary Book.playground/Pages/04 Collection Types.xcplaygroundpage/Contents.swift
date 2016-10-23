/*:
 [Previous](@previous) | [Next](@next)
 ****
 
 Copyright (c) 2016 Juan Antonio Karmy.
 Licensed under MIT License
 
 Official Apple documentation available at [Swift Language Reference](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/)
 
 See Juan Antonio Karmy - [karmy.co](http://karmy.co) | [@jkarmy](http://twitter.com/jkarmy)
 
 ****
 */


/*:
 # Collection Types
 */

import UIKit

/*:
 Arrays and dictionaries in swift use generics and can be mutable or immutable
 depending on whether they are assigned to a var or let
 Structs are VALUE types, which means that when working with mutating functions, you'll need to store them in "var".
 Everytime the struct is "mutated", a new struct will be created and stored in that var.
 */



//: ## Arrays

var shoppingList: [String] = ["Eggs", "Pigs"]
var anotherShoppingList = ["Eggs", "Pigs"]		//Both are the same


if shoppingList.isEmpty { //Checks if count == 0
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}

shoppingList.append("Cow") //At the end of the array
shoppingList += ["Bird", "Shark"]

shoppingList[1...3] = ["Bananas", "Apples", "Strawberries"] //Replace several items at once

shoppingList.insert("Maple Syrup", at: 0) //Inserts element at index

let mapleSyrup = shoppingList.remove(at: 0) // Returns removed item

var emptyArray = [Int]() //Initialize empty array, type of elements must be provided
var anotherEmptyArray: [Int] = [] // Also valid
var someArray = ["Hello", "World"]
someArray = [] // This is valid when the context already provides type information
var array = [Int](repeating: 0, count: 3) //Initalizes an array of length 3 with zeros

var compoundArray = array + emptyArray

var reversedShoppingList: [String] = shoppingList.reversed()

reversedShoppingList.removeLast() // Removes last item. Remove the first with removeFirst(). No returned value.
reversedShoppingList.popLast() // Pops the last item, removing it from the array and also returning it. Note that if the array is empty, the returned value is nil.

//: ## Dictionaries

var airports: [String: String] = ["JFK": "John F. Kennedy", "SCL": "Arturo Merino Benitez"]
airports = ["JFK": "John F. Kennedy", "SCL": "Arturo Merino Benitez"] //Also valid

airports["JFK"] = "New York"

airports.updateValue("Los Angeles", forKey:"LAX") //Updates or creates the value. Returns optional w/ previous value

if let airportName = airports["DUB"] { //Subscript always returns optional in case value is not set.
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}

airports["LAX"] = nil
airports.removeValue(forKey: "LAX") //Both remove the key-value pair

//Iterating over the whole dictionary
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

//Iterating on Keys
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
//Iterating on Values
for airportName in airports.values {
    print("Airport name: \(airportName)")
}

//Empty Dictionaries
var numbers = [Int: String]()
numbers = [:]     			  //Both do the same

numbers[16] = "sixteen"


//: ### NOTE

/*:
 You can use your own custom types as dictionary key types by making
 them conform to the Hashable protocol from Swift’s standard library.
 Types that conform to the Hashable protocol must provide a
 gettable Int property called hashValue, and must also provide an
 implementation of the “is equal” operator (==). The value returned by a
 type’s hashValue property is not required to be the same across different
 executions of the same program, or in different programs.
 
 All of Swift’s basic types (such as **String**, **Int**, **Double**, and **Bool**) are hashable by default
 */


