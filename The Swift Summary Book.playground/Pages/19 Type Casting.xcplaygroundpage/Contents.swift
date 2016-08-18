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
 ===========================================
 Defining a Class Hierarchy for Type Casting
 ===========================================
 */

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

/*
 The type of the library array is inferred by initializing it with the contents of an array literal.
 Swift’s type checker is able to deduce that Movie and Song have a common superclass of MediaItem,
 and so it infers a type of [MediaItem] for the library array.
 
 The items stored in library are still Movie and Song instances behind the scenes.
 However, if you iterate over the contents of this array, the items you receive back are typed as MediaItem,
 and not as Movie or Song. In order to work with them as their native type, you need to check their type,
 or downcast them to a different type, as described below.
 */


/*
 =============
 Checking Type
 =============
 */

/*
 Use the type check operator (is) to check whether an instance is of a certain subclass type.
 */

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")
// Prints "Media library contains 2 movies and 3 songs"


/*
 ===========
 Downcasting
 ===========
 */

/*
 A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes.
 Where you believe this is the case, you can try to downcast to the subclass type with a type cast operator (as? or as!).
 
 Because downcasting can fail, the type cast operator comes in two different forms. The conditional form, as?, returns
 an optional value of the type you are trying to downcast to. The forced form, as!, attempts the downcast and force-unwraps
 the result as a single compound action.
 */


for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: '\(song.name)', by \(song.artist)")
    }
}

// Note that "let mediaItem = movie as MediaItem" will always work. That's why you don't need to use neither the conditional form
// or the forced form.


/*
 ==================================
 Type Casting for Any and AnyObject
 ==================================
 */

/*
 Swift provides two special type aliases for working with non-specific types:
 
 AnyObject can represent an instance of any class type.
 Any can represent an instance of any type at all, including function types.
 */


/*
 =========
 AnyObject
 =========
 */


let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]

for movie in someObjects as! [Movie] {
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}


/*
 ===
 Any
 ===
 */


var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })


/*
 You can use the is and as operators in a switch statement’s cases to discover the specific type of a constant or variable
 that is known only to be of type Any or AnyObject.
 */


for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double: // Here it's valid to use is, since the only thing being queried is the type. Other case statements store values in vars, so they use as.
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}