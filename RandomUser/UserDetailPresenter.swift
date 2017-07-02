//
//  UserDetailPresenter.swift
//  RandomUser
//
//  Created by Toni on 02/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

class UserDetailPresenter: BothamPresenter {
  fileprivate let username: String
  fileprivate let getUserDetail: GetUserDetail
  fileprivate weak var ui: UserUI?
  
  init(username: String, ui: UserUI, getUserDetail: GetUserDetail) {
    self.username = username
    self.ui = ui
    self.getUserDetail = getUserDetail
  }
  
  func viewDidLoad() {
    ui?.showLoader()
    getUserDetail.execute(username: username) { (result) in
      DispatchQueue.main.async {
        self.ui?.hideLoader()
        if let error = result.error {
          self.ui?.showError(error.errorDescription)
          return
        }
        
        guard let user = result.value else {
          return
        }
        
        self.ui?.title = user.username
        self.ui?.show(user: user)
      }
    }
  }
}
