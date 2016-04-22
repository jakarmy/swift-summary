
// |=------------------------------------------------------=|
//  Copyright (c) 2016 Juan Antonio Karmy.
//  Licensed under MIT License
//
//  See https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ for Swift Language Reference
//
//  See Juan Antonio Karmy - http://karmy.co | http://twitter.com/jkarmy
//
// |=------------------------------------------------------=|


//Collection Types

// Playground - noun: a place where people can play

import UIKit

// Arrays and dictionaries in swift use generics and can be mutable or immutable
// depending on whether they are assigned to a var or let

//Arrays

var shoppingList: [String] = ["Eggs", "Pigs"]
shoppingList = ["Eggs", "Pigs"]				//Both are the same


if shoppingList.isEmpty { //Checks if count == 0
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}

shoppingList.append("Cow") //At the end of the array
shoppingList += ["Bird", "Shark"]

shoppingList[3...4] = ["Bananas", "Apples"] //Replace several items at once

shoppingList.insert("Maple Syrup", atIndex: 0) //Inserts element at index

let mapleSyrup = shoppingList.removeAtIndex(0) // Returns removed item

var emptyArray = [Int]() //Initialize empty array
emptyArray = [] //Also valid
var array = [Int](count: 3, repeatedValue: 0) //Initalizes an array of lenght 3 with zeros

var compundArray = array + emptyArray


//Dictionaries

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
airports.removeValueForKey("LAX") //Both remove the key-value pair

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


// NOTE

// You can use your own custom types as dictionary key types by making
// them conform to the Hashable protocol from Swift’s standard library.
// Types that conform to the Hashable protocol must provide a
// gettable Int property called hashValue, and must also provide an
// implementation of the “is equal” operator (==). The value returned by a
// type’s hashValue property is not required to be the same across different
// executions of the same program, or in different programs.

// All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default


