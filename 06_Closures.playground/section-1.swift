
// |=------------------------------------------------------=|
//  Copyright (c) 2016 Juan Antonio Karmy.
//  Licensed under MIT License
//
//  See https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ for Swift Language Reference
//
//  See Juan Antonio Karmy - http://karmy.co | http://twitter.com/jkarmy
//
// |=------------------------------------------------------=|

/*
 ===============
 INLINE CLOSURES
 ===============
 */

let array = ["John", "Tim", "Steve"]

var reversed = array.sort({(s1: String, s2: String) -> Bool in return s1 > s2})

//Using type inference, we can omit the params and return types. This is true when passing closures as params to a function.
reversed = array.sort({s1, s2 in return s1 > s2})

//In case of single-expression closures, the return value is implicit, thus the return expression can be omitted.
reversed = array.sort({s1, s2 in s1 == s2})

//In the previous examples, the names of the closure's params were explicit. You can use the $X variables to refer to params for the closure.
//This eliminates the need for the first params list, which makes the body the only relevant part.
reversed = array.sort({$0 == $1})

//We can even take this to an extreme. String defines its own implementation for the ">" operator, which is really all the closure does.
reversed = array.sort(>)

/*##### TRAILING CLOSURES #####*/
func someFunctionThatTakesAClosure(closure: () -> ()) {
    // function body goes here
}

//Closures which are too long to be defined inline.
// here's how you call this function without using a trailing closure:
someFunctionThatTakesAClosure({
    // closure's body goes here
})

// here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}

//Sorting function with inline closure:
array.sort() {$0 == $1}

//Note: In case the function doesn't take any params other than a trailing closure, there's no need for parenthesis.

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let stringsArray = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output //Note how the optional value returned from the dic subscript is force-unwrapped, since a value is guaranteed.
        number /= 10
    }
    return output
}
