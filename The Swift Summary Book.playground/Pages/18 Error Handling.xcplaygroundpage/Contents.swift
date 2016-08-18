
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
 ================================
 Representing and Throwing Errors
 ================================
 */

/*
 Swift enumerations are particularly well suited to modeling a group of related error conditions,
 with associated values allowing for additional information about the nature of an error to be communicated.
 */

enum VendingMachineError: ErrorProtocol {
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}

throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)

/*
 Error handling in Swift resembles exception handling in other languages, with the use of the try, catch and throw keywords.
 Unlike exception handling in many languages—including Objective-C—error handling in Swift does not involve unwinding the call stack,
 a process that can be computationally expensive. As such, the performance characteristics of a throw statement are comparable to those of a return statement.
 */

/*
 ===========================================
 Propagating Errors Using Throwing Functions
 ===========================================
 */

/*
 To indicate that a function, method, or initializer can throw an error,
 you write the throws keyword in the function’s declaration after its parameters.
 */

func canThrowErrors() throws -> String { return "" }

func cannotThrowErrors() -> String { return "" }
// A throwing function propagates errors that are thrown inside of it to the scope from which it’s called.
// Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        guard var item = inventory[name] else {
            throw VendingMachineError.InvalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        item.count -= 1
        inventory[name] = item
        dispenseSnack(snack: name)
    }
}

/*
 The implementation of the vend(itemNamed:) method uses guard statements to exit the method early
 and throw appropriate errors if any of the requirements for purchasing a snack aren’t met.
 Because a throw statement immediately transfers program control, an item will be vended only if all of these requirements are met.
 */


/*
 ==============================
 Handling Errors Using Do-Catch
 ==============================
 */

func buyFavoriteSnack(name: String, vendingMachine: VendingMachine) throws{
    throw VendingMachineError.InvalidSelection
}


var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(name: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.OutOfStock {
    print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}


/*
 ====================================
 Converting Errors to Optional Values
 ====================================
 */

func someThrowingFunction() throws -> Int {
    // ...
    return 2
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}


/*
 If someThrowingFunction() throws an error, the value of x and y is nil. Otherwise, the value of x and y
 is the value that the function returned. Note that x and y are an optional of whatever type someThrowingFunction() returns.
 Here the function returns an integer, so x and y are optional integers.
 
 Using try? lets you write concise error handling code when you want to handle all errors in the same way.
 For example, the following code uses several approaches to fetch data, or returns nil if all of the approaches fail.
 */



/*
 ===========================
 Disabling Error Propagation
 ===========================
 */

func loadImage(path: String) throws ->String {
    return "Image"
}

let photo = try! loadImage(path: "./Resources/John Appleseed.jpg")


/*
 Sometimes you know a throwing function or method won’t, in fact, throw an error at runtime.
 On those occasions, you can write try! before the expression to disable error propagation and wrap the call in a
 runtime assertion that no error will be thrown. If an error actually is thrown, you’ll get a runtime error.
 */


/*
 ==========================
 Specifying Cleanup Actions
 ==========================
 */

func exists(file: String) -> Bool{
    return true
}

func openFile(file: String) -> String{
    return ""
}

func close(file: String) -> Void{
    
}

func processFile(filename: String) throws {
    if exists(file: filename) {
        let file = openFile(file: filename)
        defer {
            close(file: file)
        }
        //        while let line = try file.readline() {
        //            // Work with the file.
        //        }
        // close(file) is called here, at the end of the scope.
    }
}


/*
 You use a defer statement to execute a set of statements just before code execution leaves the current block of code.
 This statement lets you do any necessary cleanup that should be performed regardless of how execution leaves the current block
 of code—whether it leaves because an error was thrown or because of a statement such as return or break.
 For example, you can use a defer statement to ensure that file descriptors are closed and manually allocated memory is freed.
 
 A defer statement defers execution until the current scope is exited. This statement consists of the defer keyword and the statements
 to be executed later. The deferred statements may not contain any code that would transfer control out of the statements,
 such as a break or a return statement, or by throwing an error. Deferred actions are executed in reverse order of how they are
 specified—that is, the code in the first defer statement executes after code in the second, and so on.
 
 You can use a defer statement even when no error handling code is involved.
 */

