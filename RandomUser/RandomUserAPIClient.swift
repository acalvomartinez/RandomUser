//
//  RandomUserAPIClient.swift
//  RandomUser
//
//  Created by Toni on 28/06/2017.
//  Copyright © 2017 Antonio Calvo. All rights reserved.
//

import Foundation
import Result

public enum RandomUserAPIClient {
  case getUsers(results: Int, page: Int)
}

extension RandomUserAPIClient: Resource {
  var path: String {
    switch self {
    case .getUsers(_, _):
      return "\(RandomUserAPIClientConfiguration.getUsersEndpoint)"
    }
  }
  
  var parameters: [String: String] {
    switch self {
    case .getUsers(let results, let page):
      return ["results": "\(results)", "page": "\(page)"]
    }
  }
}

extension URL {
  static func randomUsersURL() -> URL {
    guard let url = URL(string: RandomUserAPIClientConfiguration.baseEndpoint) else {
      fatalError("RandomUserAPIClient configuration not found")
    }
    return url
  }
}

extension APIClient {
  static func randomUserAPIClient() -> APIClient {
    return APIClient(baseURL: URL.randomUsersURL())
  }
  
  func getUsers(results: Int, page: Int, completion: @escaping (Result<GetUsers, RandomUserAPIClientError>) -> Void) {
    let resource = RandomUserAPIClient.getUsers(results: results, page: page)
    
    object(resource) { (result) in
      completion(result.mapErrorToRandomUserAPIClientError())
    }
  }
}
