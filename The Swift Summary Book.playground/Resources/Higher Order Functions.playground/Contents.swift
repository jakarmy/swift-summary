
/*:
 [Previous](@previous) | [Next](@next)
 ****
 
 Copyright (c) 2016 Juan Antonio Karmy.
 Licensed under MIT License
 
 Official Apple documentation available at [Swift Language Reference](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/)
 
 See Juan Antonio Karmy - [karmy.co](http://karmy.co) | [@jkarmy](http://twitter.com/jkarmy)
 
 ****
 */

//: Page created by Tien Vu - https://github.com/Tj3n

/*:
 # HIGH ORDER FUNCTIONS
 */

import UIKit

var array = [1,2,3,4,5]

//: Map: Manipulate each value in the array. They can have a different value or type.
let mapped = array.map { (value) -> Int in
    return value + 1
}

let mappedShort = array.map({ $0 + 1 })
mappedShort

//: This can be written like this since we are passing a Trailing Closure. See the Closures chapter for further information.
let mappedShort1 = array.map { $0 + 1 }
mappedShort1


//: Filter: each value in array must pass a rule to append itself into a newly made array
let filtered = array.filter { (value) -> Bool in
    return value >= 4
}

let filteredShort = array.filter({ $0 >= 4 })
filteredShort

let filteredShort1 = array.filter { $0 >= 4 }
filteredShort1


//: Reduce: combining the elements of an array to a single value

// 0 is starting value
let reduced = array.reduce(0) { (value1, value2) -> Int in
    value1 + value2
}

let reducedShort0 = array.reduce(0, ({ $0 + $1 }))
reducedShort0

let reducedShort1 = array.reduce(0) { $0 + $1 }
reducedShort1

let reducedShortest = array.reduce(0, +)
reducedShortest

// "test" is the starting value
let reducedShort2 = array.reduce("test", ({ "\($0)\($1)"}))
reducedShort2

// Mathematics functions can be used
let reducedShorter =  array.reduce(1, *)


//: Flatmap: supports optionals and squence of sequence
var multidimentionalArray: [[Int]?] = [[1,2], [3,5], [4], nil]

let flatmapped: [[Int]?] = multidimentionalArray.flatMap { (array) in
    return array != nil && array!.count > 1 ? array : []
}

let flatmappedShort = multidimentionalArray.flatMap({ $0 }) //Remove nil
flatmappedShort

let flatmappedShort1 = multidimentionalArray.flatMap { $0 } //Remove nil
flatmappedShort1
