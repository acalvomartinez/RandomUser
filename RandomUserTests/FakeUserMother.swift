//
//  FakeUserMother.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import RandomKit

@testable import RandomUser

class FakeUserMother {
  static func anyUser() -> User {
    
    let threadLocal = Xoroshiro.threadLocal
    
    let schema = "http"
    let filename = String.random(ofLength: 6, using: &threadLocal.pointee)
    let imageURLString = schema.appendingFormat("://randomuser.me/%s.jpg", filename)
    let picture = Picture(large: imageURLString,
                          medium: imageURLString,
                          thumbnail: imageURLString)
    
    let location = Location(street: String.random(ofLength: 6, using: &threadLocal.pointee),
                            city: String.random(ofLength: 6, using: &threadLocal.pointee),
                            state: String.random(ofLength: 6, using: &threadLocal.pointee))
    
    let username = String.random(ofLength: 6, using: &threadLocal.pointee)
    
    let email = username.appending("@randomuser.me")
    
    let digits = Int.random(to: 1000, using: &threadLocal.pointee)
    
    let phone = "\(digits)-\(digits)-\(digits)"
    
    let user = User(username: username,
                    firstName: String.random(ofLength: 6, using: &threadLocal.pointee),
                    lastName:String.random(ofLength: 6, using: &threadLocal.pointee),
                    email: email,
                    phone: phone,
                    gender: .female,
                    location: location,
                    picture: picture,
                    registeredAt: Date.random(using: &threadLocal.pointee))
    return user
    
  }
}

