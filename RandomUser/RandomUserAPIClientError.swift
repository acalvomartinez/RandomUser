//
//  RandomUserAPIClientError.swift
//  RandomUser
//
//  Created by Toni on 28/06/2017.
//  Copyright © 2017 Antonio Calvo. All rights reserved.
//

import Foundation
import Result

enum RandomUserAPIClientError: Error {
  case networkError
  case itemNotFound
  case unknownError(code: Int)
  case internalServerDrama
}

extension ResultProtocol where Error == APIClientError {
  func mapErrorToRandomUserAPIClientError() -> Result<Value, RandomUserAPIClientError> {
    return mapError { error in
      switch error {
      case .badStatus(404):
        return .itemNotFound
      case .badStatus(NSURLErrorNetworkConnectionLost):
        return .networkError
      case .other(let otherError):
        return .unknownError(code: otherError._code)
      case .internalServerDrama:
        return .internalServerDrama
      case .networkError:
        return .networkError
      default:
        return .internalServerDrama
      }
    }
  }
}

extension RandomUserAPIClientError: Equatable {
  static func ==(lhs: RandomUserAPIClientError, rhs: RandomUserAPIClientError) -> Bool {
    return (lhs._domain == rhs._domain) && (lhs._code == rhs._code)
  }
}

