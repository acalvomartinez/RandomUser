//
//  DuplicatesRemover.swift
//  RandomUser
//
//  Created by Antonio Calvo on 30/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation

protocol UsersFilterProtocol {
  func filter(_ users: [User], filteredUsers: [User]) -> [User]
  func filter(_ users: [User], filteredUsernames: [String]) -> [User]
}

class UsersFilter {
  func filter(_ users: [User], filteredUsers: [User]) -> [User] {
    return Array(Set(users).subtracting(filteredUsers))
  }
  
  func filter(_ users: [User], filteredUsernames: [String]) -> [User] {
    return users.filter { filteredUsernames.contains($0.username) }
  }
}
