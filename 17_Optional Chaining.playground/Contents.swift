
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
 ========================================================
 Optional Chaining as an Alternative to Forced Unwrapping
 ========================================================
 */

/*
 The main difference is that optional chaining fails gracefully when the optional is nil,
 whereas forced unwrapping triggers a runtime error when the optional is nil.
 
 The result of an optional chaining call is always an optional value, even if the property,
 method, or subscript you are querying returns a nonoptional value.
 
 Specifically, the result of an optional chaining call is of the same type as
 the expected return value, but wrapped in an optional.
 */

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
//This creates a run-time error: Unwrapping the "residence" property, which is an optional, and its value is nil
//let roomCount = john.residence!.numberOfRooms

//Doing it with optional chaining

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

/*
 ============================================
 Defining Model Classes for Optional Chaining
 ============================================
 */

class OtherPerson {
    var residence: OtherResidence?
}

class OtherResidence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

var otherResidence = OtherResidence()
otherResidence.rooms.append(Room(name: "Living Room"))
var room = otherResidence[0]


/*
 ==============================================
 Accessing Properties Through Optional Chaining
 ==============================================
 */

let bob = OtherPerson()

if let roomCount = bob.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

/*
 In this example, the attempt to set the address property of john.residence will fail,
 because john.residence is currently nil.
 
 The assignment is part of the optional chaining, which means none of the code on the
 right hand side of the = operator is evaluated.
 */

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
bob.residence?.address = someAddress

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

bob.residence?.address = createAddress()
bob.residence = otherResidence

/*
 If you call this method on an optional value with optional chaining, the method’s return type will be Void?,
 not Void, because return values are always of an optional type when called through optional chaining.
 This enables you to use an if statement to check whether it was possible to call the
 printNumberOfRooms() method, even though the method does not itself define a return value.
 */

if let void = bob.residence?.printNumberOfRooms() {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

/*
 Any attempt to set a property through optional chaining returns a value of type Void?,
 which enables you to compare against nil to see if the property was set successfully:
 */

if (bob.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}

/*
 ==============================================
 Accessing Subscripts Through Optional Chaining
 ==============================================
 */

if let firstRoomName = bob.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

bob.residence?.rooms.append(Room(name: "Bathroom"))


/*
 Accessing Subscripts of Optional Type
 */

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72

// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
testScores["Dave"]
testScores["Bev"]

/*
 - If you try to retrieve an Int value through optional chaining, an Int? is always returned,
 no matter how many levels of chaining are used.
 
 - Similarly, if you try to retrieve an Int? value through optional chaining,
 an Int? is always returned, no matter how many levels of chaining are used.
 */

if let bobsStreet = bob.residence?.address?.street {
    print("Bob's street name is \(bobsStreet).")
} else {
    print("Unable to retrieve the address.")
}

/*
 Chaining on Methods with Optional Return Values
 */

if let beginsWithThe =
    bob.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
