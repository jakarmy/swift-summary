
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

// Deinitializers are only available on class types.
/*
 Deinitializers are called automatically, just before instance deallocation takes place.
 You are not allowed to call a deinitializer yourself.
 Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer
 is called automatically at the end of a subclass deinitializer implementation.
 Superclass deinitializers are always called, even if a subclass does not provide its own deinitializer.
 */

class Bank {
    static var coinsInBank = 10_000
    static func vendCoins(numberOfCoinsToVend: Int) -> Int {
        let numberOfCoinsAllowedToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsAllowedToVend
        return numberOfCoinsAllowedToVend
    }
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(numberOfCoinsToVend: coins)
    }
    func winCoins(coins: Int) {
        coinsInPurse += Bank.vendCoins(numberOfCoinsToVend: coins)
    }
    deinit {
        Bank.receiveCoins(coins: coinsInPurse)
    }
}

/*
 An optional variable is used here, because players can leave the game at any point.
 The optional lets you track whether there is currently a player in the game.
 */
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// prints "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// prints "There are now 9900 coins left in the bank"


playerOne!.winCoins(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// prints "PlayerOne won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left")
// prints "The bank now only has 7900 coins left"


playerOne = nil //Just before this happens, its deinitializer is called automatically.
print("PlayerOne has left the game")
// prints "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// prints "The bank now has 10000 coins"
