
// |=------------------------------------------------------=|
//  Copyright (c) 2016 Juan Antonio Karmy.
//  Licensed under MIT License
//
//  See https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ for Swift Language Reference
//
//  See Juan Antonio Karmy - http://karmy.co | http://twitter.com/jkarmy
//
// |=------------------------------------------------------=|

func sayHello(personName: String) -> String{
    return "Hello \(personName)!"
}

//In this case we return a tuple
func minMax(array: [Int]) -> (min: Int, max:Int)? {
    if array.isEmpty {return nil}
    return (0,1)
}

//Note: returning void translates in returning an empty tuple: ()

//Here we are using external and local params names.
//Also, note how the last param is predefined. This means we can omit it when calling the function.
//Also note that an external name will be provided automatically to every predefined param.
func join(string s1: String, toString s2: String, withJoiner joiner: String = " ")
    -> String {
        return s1 + joiner + s2
}

//A variadic param can take more than one value of a specified type.
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

//In this example, the inout prefix defines that the passed parameters' values can be modified,
//and this will be reflected on the original variables defined outside of the function.
func swapTwoInts( a: inout Int, b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//You can use a function type to pass functions as params to other functions.
func printMathResult(mathFunction: (Int, Int) -> Int, a: Int, b: Int) {
    print("Result: \(mathFunction(a, b))")
}

//You can use function type to return functions.
//Here, we are also defining nested functions. These functions can only be accessed through the parent function.
//but can be passed as return values.
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward : stepForward
}


//Start
sayHello(personName: "Juan")

minMax(array: [])

join(string: "Hello", toString: "World", withJoiner: "New")
join(string: "", toString: "")

arithmeticMean(numbers: 4,5,6,7)

var someInt = 3
var anotherInt = 107
swapTwoInts(a: &someInt, b: &anotherInt)

//Here we are defining a var of type function.
var mathFunction: (String) -> String = sayHello
