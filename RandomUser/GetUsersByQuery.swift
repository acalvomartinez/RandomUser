//
//  GetUsersByQuery.swift
//  RandomUser
//
//  Created by Toni on 02/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import Result

class GetUsersByQuery {
  
  fileprivate let richModel: UsersRichModel
  
  init(richModel: UsersRichModel) {
    self.richModel = richModel
  }
  
  func execute(query: String,_ isActive: Bool, _ completion: @escaping (Result<[UserListItemViewModel], UsersError>) -> ()) {
    richModel.getUsers(withQueryString: query, isActive) { result in
      completion(result)
    }
  }
}
