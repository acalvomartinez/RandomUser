//
//  UsersRichModel.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import Result

class UsersRichModel {
  fileprivate let repository: UsersRepository
  fileprivate let usersFilter: UsersFilter
  fileprivate let deletedUsernames: DeletedUsernames
  fileprivate var users: [User]
  
  fileprivate let queue = DispatchQueue(label: "me.antoniocalvo.UsersRichModel", qos: DispatchQoS.background)
  
  init(repository: UsersRepository, usersFilter: UsersFilter, deletedUsernames: DeletedUsernames) {
    self.repository = repository
    self.usersFilter = usersFilter
    self.deletedUsernames = deletedUsernames
    self.users = []
  }
  
  func getUsers(page: Int, results: Int, _ completion: @escaping (Result<[User], UsersError>) -> ()) {
    repository.getUsers(page: page, results: results) { result in
      completion(result.flatMap { (users) -> Result<[User], UsersError> in
        var usersInPage = self.usersFilter.filterExisting(users, withUsers: self.users)
        usersInPage = self.usersFilter.filterExisting(usersInPage, withUsernames: self.deletedUsernames.getAll())
        self.users.append(contentsOf: usersInPage)
        
        return Result(value: usersInPage)
      })
    }
  }
  
  func delete(_ username: String, _ completion: @escaping (Result<User, UsersError>) -> ()) {
    self.queue.async {
      guard let userToDelete = self.users.filter({ $0.username == username }).first else {
        completion(Result(error: .itemNotFound))
        return
      }
      
      self.deletedUsernames.add(userToDelete.username)
      self.users = self.usersFilter.filterExisting(self.users, withUsernames: self.deletedUsernames.getAll())
      
      completion(Result(value: userToDelete))
    }
  }
  
  func getUser(withUsername username: String, _ completion: @escaping (Result<User, UsersError>) -> ()) {
    self.queue.async {
      guard let user = self.users.filter({ $0.username == username }).first else {
        completion(Result(error: .itemNotFound))
        return
      }
      
      completion(Result(value: user))
    }
  }
  
  func getUsers(withQueryString queryString: String, _ completion: @escaping (Result<[User], UsersError>) -> ()) {
    self.queue.async {
      let filteredUsers = self.users.filter({ $0.firstName.contains(queryString) ||  $0.lastName.contains(queryString) ||  $0.email.contains(queryString) })
      
      completion(Result(value: filteredUsers))
    }
  }
}

