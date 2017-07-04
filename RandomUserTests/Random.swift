//
//  Random.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation

@testable import RandomUser

extension String {
  static func random(ofLength length: Int) -> String {
    let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let allowedCharsCount = UInt32(allowedChars.characters.count)
    var randomString = ""
    
    for _ in 0..<length {
      let randomNum = Int(arc4random_uniform(allowedCharsCount))
      let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
      let newCharacter = allowedChars[randomIndex]
      randomString += String(newCharacter)
    }
    
    return randomString
  }
}

extension Int {
  static func random(within range: ClosedRange<Int>) -> Int {
    return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
  }
}

extension Bool {
  static func random() -> Bool {
    return Int.random(within: 0...99) < 50
  }
}

extension Gender {
  static func random() -> Gender {
    if Bool.random() { return .female } else { return .male }
  }
}
