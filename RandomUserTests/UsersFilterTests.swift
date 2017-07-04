//
//  UsersFilterTests.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import XCTest

@testable import RandomUser

class UsersFilterTests: XCTestCase {
  func testFilterUsersWhenThereAreDuplicates() {
    var groupOfUsersA = givenAGroupOfUsers()
    let duplicatedUser = FakeUserMother.anyUser()
    groupOfUsersA.append(duplicatedUser)
    
    var groupOfUsersB = givenAGroupOfUsers()
    groupOfUsersB.append(duplicatedUser)
    
    let userFilterSUT = UsersFilter()
    let result = userFilterSUT.filterExisting(groupOfUsersA, withUsers: groupOfUsersB)
    
    assert(result.count == groupOfUsersA.count - 1)
  }
  
  func testFilterUsersWhenThereAreNotDuplicates() {
    let groupOfUsersA = givenAGroupOfUsers()
    let groupOfUsersB = givenAGroupOfUsers()
    
    let userFilterSUT = UsersFilter()
    let result = userFilterSUT.filterExisting(groupOfUsersA, withUsers: groupOfUsersB)
    
    assert(result.count == groupOfUsersA.count)
  }
  
  func testFilterUsersWhenThereAreDeletedUsers() {
    let groupOfUsers = givenAGroupOfUsers()
    let deletedUsers = [groupOfUsers.first!.username, groupOfUsers.last!.username];
    
    let userFilterSUT = UsersFilter()
    let result = userFilterSUT.filterExisting(groupOfUsers, withUsernames: deletedUsers)
    
    assert(result.count == groupOfUsers.count - deletedUsers.count)
  }
  
  func testFilterUsersWhenThereAreNotDeletedUsers() {
    let groupOfUsers = givenAGroupOfUsers()
    
    let deletedUser = FakeUserMother.anyUser()
    let deletedUsers = [deletedUser.username];
    
    let userFilterSUT = UsersFilter()
    let result = userFilterSUT.filterExisting(groupOfUsers, withUsernames: deletedUsers)
    
    assert(result.count == groupOfUsers.count)
  }
  
  fileprivate func givenAGroupOfUsers(_ numberOfUsers: Int = 5) -> [User] {
    var users = [User]()
    for _ in 0..<numberOfUsers {
      let user = FakeUserMother.anyUser()
      users.append(user)
    }
    return users
  }
}
