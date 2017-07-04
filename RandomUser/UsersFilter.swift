//
//  DuplicatesRemover.swift
//  RandomUser
//
//  Created by Antonio Calvo on 30/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation

class UsersFilter {
  func filterExisting(_ users: [User], withUsers exitingUsers: [User]) -> [User] {
    return users.filter { !exitingUsers.contains($0) }
  }
  
  func filterExisting(_ users: [User], withUsernames usernames: [String]) -> [User] {
    return users.filter { !usernames.contains($0.username) }
  }
}
