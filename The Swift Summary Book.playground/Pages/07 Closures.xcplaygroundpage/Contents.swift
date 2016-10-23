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
 # CLOSURES
 */


/*:
 ## INLINE CLOSURES
 */

var array = ["John", "Tim", "Steve"]

var reversed = array.sorted(by: {(s1: String, s2: String) -> Bool in return s1 > s2})

//: Using type inference, we can omit the params and return types. This is true when passing closures as params to a function.
reversed = array.sorted(by: {s1, s2 in return s1 > s2})

//: In case of single-expression closures, the return value is implicit, thus the return expression can be omitted.
reversed = array.sorted(by: {s1, s2 in s1 == s2})

/*: In the previous examples, the names of the closure's params were explicit.
 You can use the $X variables to refer to params for the closure
 This eliminates the need for the first params list, which makes the body the only relevant part.
 */
reversed = array.sorted(by: {$0 == $1})

//: We can even take this to an extreme. String defines its own implementation for the ">" operator, which is really all the closure does.
reversed = array.sorted(by: >)



//: ## TRAILING CLOSURES
func someFunctionThatTakesAClosure(closure: () -> ()) {
    // function body goes here
}

/*:
 Closures which are too long to be defined inline.
 Here's how you call this function without using a trailing closure:
 */
someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

//: Here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}

//Sorting function with inline closure:
array.sort() {$0 == $1}

//: **Note**: In case the function doesn't take any params other than a trailing closure, there's no need for parenthesis.

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

//: ## AUTOCLOSURES

/*:
 An autoclosure is a closure that is automatically created to wrap an expression that’s being passed as an argument to a function.
 It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it.
 This syntactic convenience lets you omit braces around a function’s parameter by writing a normal expression instead of an explicit closure.
 
 An autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure.
 */

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
let customerProvider = { customersInLine.remove(at: 0) }

//: Traditional way
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!") //The closure is called here!
}
serve(customer: { customersInLine.remove(at: 0) } )

//: **@autoclosure** way
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0)) //We are not required to use the curly braces, since the code will be wrapped in a closure thanks to @autoclosure
