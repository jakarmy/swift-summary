
// |=------------------------------------------------------=|
//  Copyright (c) 2016 Juan Antonio Karmy.
//  Licensed under MIT License
//
//  See https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ for Swift Language Reference
//
//  See Juan Antonio Karmy - http://karmy.co | http://twitter.com/jkarmy
//
// |=------------------------------------------------------=|


//BASIC OPERATORS

// Playground - noun: a place where people can play

import UIKit

let (x, y) = (1, 2)

//Addition is also available for strings
let string = "hello, " + "world"

//Nil Coalescing Operator
//It's equivalent to (a ? b : c), but for optionals

var optional: String? //Currently nil

optional ?? "Some Value"

// if (let optional != nil){
// 	optional = !optional //Unwrapped value
// }else{
// 	optional = "Some Value"
// }

//Range operators
for index in 1...5 {
    //It will iterate 5 times.
}

var array = [1,2,3]

for index in 0..<array.count{
    //It will iterate (array.count - 1) times.
}

