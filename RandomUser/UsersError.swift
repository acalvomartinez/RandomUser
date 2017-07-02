//
//  UsersError.swift
//  RandomUser
//
//  Created by Antonio Calvo on 30/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import Result

public enum UsersError: Error {
    case networkError
    case itemNotFound
    case unknownError(code: Int)
}

extension ResultProtocol where Error == APIClientError {
    func mapErrorToUserError() -> Result<Value, UsersError> {
        return mapError { error in
            switch error {
            case .badStatus(status: 404):
                return UsersError.itemNotFound
            case .unknown(let error):
                return UsersError.unknownError(code: error._code)
            default:
                return UsersError.networkError
            }
        }
    }
}

extension UsersError: LocalizedError {
  public var errorDescription: String {
    switch self {
    case .networkError:
      return "Oops! Something happens with the network"
    case .itemNotFound:
      return "Oops! Item not found, sorry"
    case .unknownError(let code):
      return "Oops! There is an unkown error with code \(code)"
    }
  }
}
