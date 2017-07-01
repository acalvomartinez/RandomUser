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
  fileprivate let randomUserAPIClient: APIClient
  
  fileprivate let queue = DispatchQueue(label: "me.antoniocalvo.UsersRepository", qos: DispatchQoS.background)
  
  static let numberOfItemsInPage = 40
  
  init(randomUserAPIClient: APIClient) {
    self.randomUserAPIClient = randomUserAPIClient
    
  }
  
  func getUsers(page: Int = 1, results: Int = numberOfItemsInPage, _ completion: @escaping (Result<[User], UsersError>) -> ()) {
    randomUserAPIClient.getUsers(results: results, page: page) { result in
      self.queue.async {
        completion(result.flatMap { (getUsersResult) -> Result<[User], APIClientError> in
          return Result(value: getUsersResult.users)
          
          }.mapErrorToUserError())
      }
    }
  }
  
}
