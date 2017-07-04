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
  static let deletedUsernames = DefaultsKey<[String]>("deletedUsernames")
}

protocol DeletedUsernames {
  func getAll() -> [String]
  func add(_ username: String)
}

class UserDefaultsDeletedUsernames: DeletedUsernames {
  func getAll() -> [String] {
    return Defaults[.deletedUsernames]
  }
  func add(_ username: String) {
    Defaults[.deletedUsernames].append(username)
  }
}
