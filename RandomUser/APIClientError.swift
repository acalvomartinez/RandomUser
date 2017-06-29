//
//  APIClientError.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Antonio Calvo. All rights reserved.
//

import Foundation

enum APIClientError: Error {
  case networkError
  case couldNotDecodeJSON
  case badStatus(status: Int)
  case internalServerDrama
  case other(Error)
  
  
}

extension APIClientError: Equatable {
  static func ==(lhs: APIClientError, rhs: APIClientError) -> Bool {
    return (lhs._domain == rhs._domain) && (lhs._code == rhs._code)
  }
}

extension APIClientError {
  static func build(error: Error) -> APIClientError {
    switch error._code {
    case 500:
      return .internalServerDrama
    case NSURLErrorNetworkConnectionLost:
      return .networkError
    default:
      return .other(error)
    }
  }
}
