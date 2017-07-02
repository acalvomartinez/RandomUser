//
//  GetUsers.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import Result

class DeleteUser {
  fileprivate let richModel: UsersRichModel
  
  init(richModel: UsersRichModel) {
    self.richModel = richModel
  }
  
  func execute(user: User, _ completion: @escaping (Result<[User], UsersError>) -> ()) {
    richModel.delete(user) { (result) in
      completion(result)
    }
  }
}
