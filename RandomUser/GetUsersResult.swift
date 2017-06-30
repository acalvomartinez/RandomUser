//
//  GetUsersResult.swift
//  RandomUser
//
//  Created by Toni on 29/06/2017.
//  Copyright © 2017 Antonio Calvo. All rights reserved.
//

import Foundation

struct GetUsersResult {
  let page: Int
  let results: Int
  let users: [User]
}

extension GetUsersResult: JSONDecodable {
  init?(dictionary: JSONDictionary) {
    guard
      let infoJSON = dictionary["info"] as? JSONDictionary,
      let page = infoJSON["page"] as? Int,
      let results = infoJSON["results"] as? Int,
      let usersJSONArray = dictionary["results"] as? [JSONDictionary]
      else {
        return nil
    }
    self.page = page
    self.results = results
    self.users = JSONDecoder.decode(usersJSONArray) ?? []
  }
}
