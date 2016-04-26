// Created by Tien Vu - https://github.com/Tj3n

//: HIGH ORDER FUNCTIONS
// Playground - noun: a place where people can play

import UIKit

var array = [1,2,3,4,5]

//: Map: each value in array become another value (can become different type also)
let mapped = array.map { (value) -> Int in
    return value+1
}

let mappedShort = array.map({ "\($0) in String"})
mappedShort


//: Filter: each value in array must passed a rule to append itself into newly made array
let filtered = array.filter { (value) -> Bool in
    return value >= 4
}

let filteredShort = array.filter({ $0 > 2 })
filteredShort


//: Reduce: combining the elements of an array to a single value

// 0 is starting value
let reduced = array.reduce(0) { (value1, value2) -> Int in
    value1 + value2
}

let reducedShort = array.reduce(0, combine: ({ $0 + $1 }))
reducedShort

// "test" is starting value
let reducedShort2 = array.reduce("test", combine: ({ "\($0)\($1)"}))
reducedShort2

// Can be mathematics function
let reducedShorter =  array.reduce(1, combine: *)


//: Flatmap: support optional and squence of sequence
var multidimentionalArray: [[Int]?] = [[1,2], [3,5], [4], nil]

let flatmapped: [[Int]?] = multidimentionalArray.flatMap { (array) in
    return array?.count > 1 ? array : []
}

let flatmappedShort = multidimentionalArray.flatMap({ $0 }) //Remove nil
flatmappedShort
