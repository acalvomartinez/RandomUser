//
//  UsersPresenter.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

class UsersPresenter: BothamPresenter, BothamNavigationPresenter, BothamPullToRefreshPresenter {
  fileprivate weak var ui: UsersUI?
  fileprivate let getUsers: GetUsers
  
  fileprivate var users: [User] = []
  fileprivate var page: Int = 0
  
  init(ui: UsersUI, getUsers: GetUsers) {
    self.ui = ui
    self.getUsers = getUsers
  }
  
  func viewDidLoad() {
    ui?.showLoader()
    getNextUsersPage()
  }
  
  func itemWasTapped(_ item: User) {
    
  }
  
  func didStartRefreshing() {
    self.page = 0
    self.users = []
    getNextUsersPage()
  }
  
  fileprivate func getNextUsersPage() {
    let nextPage = page + 1
    self.getUsersPage(nextPage)
  }
  
  fileprivate func getUsersPage(_ nextPage: Int) {
    getUsers.execute(page: page, results: 40) { (result) in
      DispatchQueue.main.async {
        self.ui?.hideLoader()
        self.ui?.stopRefreshing()
        if let error = result.error {
          // show error
          return
        }
        
        self.page = nextPage
        
        guard let usersInPage = result.value else {
          return
        }
        
        self.users.append(contentsOf: usersInPage)
        
        if self.users.isEmpty {
          self.ui?.showEmptyResult()
        } else {
          self.ui?.show(items: self.users)
        }
      }
    }
  }
}

