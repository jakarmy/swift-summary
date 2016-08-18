
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
 Definition of an Enum
 In this case, there's no default value for the enum members.
 */
enum CompassPoint {
    case North
    case South
    case East
    case West
}

/*
 Defines an enum with members with explicit types.
 */
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

/*
 In this case, the enum is defined with raw values.
 They must be unique
 */
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

var someEnum = CompassPoint.East

//Once the type is known, it can be omitted for reassignment.
someEnum = .West

print("This is the enum: \(someEnum)")
(someEnum == .West) ? print("Equal") : print("Not Equal")

var newEnum = Barcode.QRCode("162534")
newEnum = Barcode.QRCode("692438")

let asciiCode = ASCIIControlCharacter.Tab
print("Code is \(asciiCode.rawValue)")

//In this case, since it's not guaranteed to find an enum for the specified rawValue, the initializer returns an optional

if let lineFeed = ASCIIControlCharacter(rawValue: "\r") {
    //Do something
    print(lineFeed)
}

