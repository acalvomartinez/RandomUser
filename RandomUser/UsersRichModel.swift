//
//  UsersRichModel.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import Result

protocol UsersRichModelProtocol {
  func getUsers(page: Int, results: Int, _ completion: @escaping (Result<[UserListItemViewModel], UsersError>) -> ())
  func getUsers(withQueryString queryString: String,_ isActive: Bool, _ completion: @escaping (Result<[UserListItemViewModel], UsersError>) -> ())
  func getDetail(withUsername username: String, _ completion: @escaping (Result<UserViewModel, UsersError>) -> ())
  func delete(_ user: UserListItemViewModel, _ completion: @escaping (Result<[UserListItemViewModel], UsersError>) -> ())
}

class UsersRichModel: UsersRichModelProtocol {
  static let sharedInstance = UsersRichModel()
  
  fileprivate let repository: UsersRepository
  fileprivate let usersFilter: UsersFilter
  fileprivate let deletedUsernames: DeletedUsernames
  
  fileprivate var users = [User]()
  
  fileprivate let queue = DispatchQueue(label: "me.antoniocalvo.UsersRichModel", qos: DispatchQoS.background)
  
  init() {
    self.repository = UsersRepository(randomUserAPIClient: APIClient.randomUserAPIClient())
    self.usersFilter = UsersFilter()
    self.deletedUsernames = UserDefaultsDeletedUsernames()
  }
  
  func getUsers(page: Int, results: Int, _ completion: @escaping (Result<[UserListItemViewModel], UsersError>) -> ()) {
    repository.getUsers(page: page, results: results) { result in
      completion(result.flatMap { (users) -> Result<[UserListItemViewModel], UsersError> in
        var usersInPage = self.usersFilter.filterExisting(users, withUsers: self.users)
        usersInPage = self.usersFilter.filterExisting(usersInPage, withUsernames: self.deletedUsernames.getAll())
        self.users.append(contentsOf: usersInPage)
        
        
        let usersViewModel = self.users.map {
          UserListItemViewModel(username: $0.username,
                                displayName: $0.displayName,
                                email: $0.email,
                                phone: $0.phone,
                                photo: $0.picture.pictureURL(size: .medium))
        }
        return Result(value: usersViewModel)
      })
    }
  }
  
  func delete(_ user: UserListItemViewModel, _ completion: @escaping (Result<[UserListItemViewModel], UsersError>) -> ()) {
    self.queue.async {
      guard let userToDelete = self.users.filter({ $0.username == user.username }).first else {
        completion(Result(error: .itemNotFound))
        return
      }
      
      self.deletedUsernames.add(userToDelete.username)
      self.users = self.usersFilter.filterExisting(self.users, withUsernames: [userToDelete.username])

      let usersViewModel = self.users.map {
        UserListItemViewModel(username: $0.username,
                              displayName: $0.displayName,
                              email: $0.email,
                              phone: $0.phone,
                              photo: $0.picture.pictureURL(size: .medium))
      }
      completion(Result(value: usersViewModel))
    }
  }
  
  func getDetail(withUsername username: String, _ completion: @escaping (Result<UserViewModel, UsersError>) -> ()) {
    self.queue.async {
      guard let user = self.users.filter({ $0.username == username }).first else {
        completion(Result(error: .itemNotFound))
        return
      }
      
      let userViewModel = UserViewModel(username: user.username,
                                        displayName: user.displayName,
                                        gender: user.gender.rawValue,
                                        street: user.location.street,
                                        city: user.location.city,
                                        state: user.location.state,
                                        registeredAt: user.registeredAt.toString(),
                                        email: user.email,
                                        phone: user.phone,
                                        photo: user.picture.pictureURL(size: .large))
      
      completion(Result(value: userViewModel))
    }
  }
  
  func getUsers(withQueryString queryString: String,_ isActive: Bool, _ completion: @escaping (Result<[UserListItemViewModel], UsersError>) -> ()) {
    if (!isActive || queryString == "") {
      let usersViewModel = self.users.map {
        UserListItemViewModel(username: $0.username,
                              displayName: $0.displayName,
                              email: $0.email,
                              phone: $0.phone,
                              photo: $0.picture.pictureURL(size: .medium))
      }
      completion(Result(value: usersViewModel))
      return
    }
    
    self.queue.async {
      let filteredUsers = self.users.filter({ $0.firstName.contains(queryString) ||  $0.lastName.contains(queryString) ||  $0.email.contains(queryString) })
      let usersViewModel = filteredUsers.map {
        UserListItemViewModel(username: $0.username,
                              displayName: $0.displayName,
                              email: $0.email,
                              phone: $0.phone,
                              photo: $0.picture.pictureURL(size: .medium))
      }
      completion(Result(value: usersViewModel))
    }
  }
}

