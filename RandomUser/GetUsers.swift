//
//  GetUsers.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import Result

class GetUsers {
  fileprivate let richModel: UsersRichModelProtocol
  
  static let numberOfItemsInPage = 40
  
  init(richModel: UsersRichModelProtocol) {
    self.richModel = richModel
  }
  
  func execute(page: Int = 1, results: Int = numberOfItemsInPage, _ completion: @escaping (Result<[UserListItemViewModel], UsersError>) -> ()) {
    richModel.getUsers(page: page, results: results) { result in
      completion(result)
    }
  }
}
