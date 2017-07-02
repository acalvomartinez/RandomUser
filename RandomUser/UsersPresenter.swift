//
//  UsersPresenter.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

class UsersPresenter: NSObject, UsersListPresenter, UISearchResultsUpdating {
  fileprivate weak var ui: UsersUI?
  fileprivate let getUsers: GetUsers
  fileprivate let getUsersByQuery: GetUsersByQuery
  fileprivate let deleteUser: DeleteUser
  
  fileprivate var page: Int = 0
  
  let numberOfUsersInPage = 20
  
  init(ui: UsersUI, getUsers: GetUsers, getUsersByQuery: GetUsersByQuery ,deleteUser: DeleteUser) {
    self.ui = ui
    self.getUsers = getUsers
    self.getUsersByQuery = getUsersByQuery
    self.deleteUser = deleteUser
  }
  
  func viewDidLoad() {
    ui?.showLoader()
    getNextUsersPage()
  }
  
  func itemWasTapped(_ item: UserListItemViewModel) {
    let userDetailViewController = ServiceLocator.sharedInstance.provideUserDetailViewController(item.username)
    
    self.ui?.openUserDetailScreen(userDetailViewController)
  }
  
  func loadMoreData() {
    getNextUsersPage()
  }
  
  func delete(_ item: UserListItemViewModel) {
    deleteUser.execute(user: item) { (result) in
      DispatchQueue.main.async {
        if let error = result.error {
          self.ui?.showError(error.errorDescription)
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
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let query = searchController.searchBar.text else {
      return
    }
    getUsersByQuery.execute(query: query.lowercased(), searchController.isActive) { (result) in
      DispatchQueue.main.async {
        if let error = result.error {
          self.ui?.showError(error.errorDescription)
          return
        }
        guard let users = result.value else {
          return
        }
        
        self.ui?.show(items: users)
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
          self.ui?.showError(error.errorDescription)
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

