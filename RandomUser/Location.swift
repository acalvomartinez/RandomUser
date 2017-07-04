//
//  Location.swift
//  RandomUser
//
//  Created by Antonio Calvo on 28/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation

struct Location {
    let street: String
    let city: String
    let state: String
}

extension Location: JSONDecodable {
  init?(dictionary: JSONDictionary) {
    guard
      let street = dictionary["street"] as? String,
      let city = dictionary["city"] as? String,
      let state = dictionary["state"] as? String
      else {
        return nil
    }
    self.street = street
    self.city = city
    self.state = state
  }
}

