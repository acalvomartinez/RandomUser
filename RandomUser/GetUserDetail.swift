//
//  GetUserDetail.swift
//  RandomUser
//
//  Created by Toni on 02/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import Result

class GetUserDetail {
  
  fileprivate let richModel: UsersRichModelProtocol
  
  init(richModel: UsersRichModelProtocol) {
    self.richModel = richModel
  }
  
  func execute(username: String, _ completion: @escaping (Result<UserViewModel, UsersError>) -> ()) {
    richModel.getDetail(withUsername: username) { (result) in
      completion(result)
    }
  }
}
