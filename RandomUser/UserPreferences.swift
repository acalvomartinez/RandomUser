//
//  UserPreferences.swift
//  RandomUser
//
//  Created by Antonio Calvo on 30/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
  static let deletedUsers = DefaultsKey<[String]>("deletedUsers")
}

protocol UserPreferencesProtocol {
  var deletedUsers: [String] { get set }
  func addDeletedUser(username: String)
  func clear()
}

class UserPreferences: UserPreferencesProtocol {
  var deletedUsers: [String] {
    get {
      return Defaults[.deletedUsers]
    }
    set {
      Defaults[.deletedUsers] = newValue
    }
  }
  
  func addDeletedUser(username: String) {
    Defaults[.deletedUsers].append(username)
  }
  
  func clear() {
    deletedUsers = []
  }
}
