//
//  MockUserRepository.swift
//  RandomUser
//
//  Created by Toni on 03/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import Result

@testable import RandomUser

class MockUsersAPIClient: RandomAPIClientProtocol {
  func getUsers(results: Int, page: Int, completion: @escaping (Result<GetUsersResult, APIClientError>) -> Void) {
    
  }
}
