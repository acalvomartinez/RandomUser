//
//  FakeUserMother.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation

@testable import RandomUser

class FakeUserMother {
  static func anyUser() -> User {
    let schema = "http"
    let filename = String.random(ofLength: 6)
    let imageURLString = schema.appendingFormat("://randomuser.me/%s.jpg", filename)
    let picture = Picture(large: imageURLString,
                          medium: imageURLString,
                          thumbnail: imageURLString)
    
    let location = Location(street: String.random(ofLength: 6),
                            city: String.random(ofLength: 6),
                            state: String.random(ofLength: 6))
    
    let username = String.random(ofLength: 6)
    
    let email = username.appending("@randomuser.me")
    
    let digits = Int.random(within: 100...999)
    
    let phone = "\(digits)-\(digits)-\(digits)"
    
    let user = User(username: username,
                    firstName: String.random(ofLength: 6),
                    lastName:String.random(ofLength: 6),
                    email: email,
                    phone: phone,
                    gender: Gender.random(),
                    location: location,
                    picture: picture,
                    registeredAt: Date())
    return user
    
  }
}



