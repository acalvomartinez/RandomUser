//
//  UsersRepository.swift
//  RandomUser
//
//  Created by Antonio Calvo on 30/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import Result

class UsersRepository {
  fileprivate let randomUserAPIClient: RandomUserAPIClientProtocol
  fileprivate let deletedUsernames: DeletedUsernames
  fileprivate let usersFilter: UsersFilterProtocol
  fileprivate var users: [User]
  
  fileprivate let queue = DispatchQueue(label: "me.antoniocalvo.UsersRepository", qos: DispatchQoS.background)
  
  static let numberOfItemsInPage = 40
  
  init(randomUserAPIClient: RandomUserAPIClientProtocol, deletedUsernames: DeletedUsernames, usersFilter: UsersFilterProtocol) {
    self.randomUserAPIClient = randomUserAPIClient
    self.deletedUsernames = deletedUsernames
    self.usersFilter = usersFilter
    self.users = []
  }
  
  func getUsers(page: Int = 1, results: Int = numberOfItemsInPage, _ completion: @escaping (Result<[User], UsersError>) -> ()) {
    randomUserAPIClient.getUsers(results: results, page: page) { result in
      self.queue.async {
        completion(result.flatMap { (getUsersResult) -> Result<[User], APIClientError> in
          var usersInPage = self.usersFilter.filter(getUsersResult.users, filteredUsers: self.users)
          usersInPage = self.usersFilter.filter(usersInPage, filteredUsernames: self.deletedUsernames.getAll())
          self.users.append(contentsOf: usersInPage)
          
          return Result(value: usersInPage)
          
          }.mapErrorToUserError())
      }
    }
  }
  
  func delete(_ username: String, _ completion: @escaping (Result<User, UsersError>) -> ()) {
    self.queue.async {
      guard let userToDelete = self.users.filter({ $0.username == username }).first else {
        completion(Result(error: .itemNotFound))
        return
      }
      
      self.deletedUsernames.add(userToDelete.username)
      self.users = self.usersFilter.filter(self.users, filteredUsernames: self.deletedUsernames.getAll())
      
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
  
  func getUser(withQueryString queryString: String, _ completion: @escaping (Result<[User], UsersError>) -> ()) {
    self.queue.async {
      let filteredUsers = self.users.filter({ $0.firstName.contains(queryString) ||  $0.lastName.contains(queryString) ||  $0.email.contains(queryString) })
      
      completion(Result(value: filteredUsers))
    }
  }
}
