//
//  UsersPresenter.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

class UsersPresenter: UsersListPresenter {
  fileprivate weak var ui: UsersUI?
  fileprivate let getUsers: GetUsers
  fileprivate let deleteUser: DeleteUser
  
  fileprivate var page: Int = 0
  
  let numberOfUsersInPage = 5
  
  init(ui: UsersUI, getUsers: GetUsers, deleteUser: DeleteUser) {
    self.ui = ui
    self.getUsers = getUsers
    self.deleteUser = deleteUser
  }
  
  func viewDidLoad() {
    ui?.showLoader()
    getNextUsersPage()
  }
  
  func itemWasTapped(_ item: User) {
    print("user tapped")
  }
  
  func loadMoreData() {
    getNextUsersPage()
  }
  
  func delete(_ item: User) {
    deleteUser.execute(user: item) { (result) in
      DispatchQueue.main.async {
        if let error = result.error {
          self.ui?.showError(error.description)
          return
        }
        guard let users = result.value else {
          return
        }
        
        if users.isEmpty {
          self.ui?.showEmptyResult()
        }
      }
    }
  }
  
  fileprivate func getNextUsersPage() {
    let nextPage = page + 1
    self.getUsersPage(nextPage)
  }
  
  fileprivate func getUsersPage(_ nextPage: Int) {
    getUsers.execute(page: page, results: numberOfUsersInPage) { (result) in
      DispatchQueue.main.async {
        self.ui?.hideLoader()
        if let error = result.error {
          // show error
          return
        }
        
        self.page = nextPage
        
        guard let users = result.value else {
          return
        }
        
        if users.isEmpty {
          self.ui?.showEmptyResult()
        } else {
          self.ui?.show(items: users)
        }
      }
    }
  }
}

