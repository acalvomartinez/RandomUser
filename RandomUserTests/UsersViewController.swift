//
//  UsersViewController.swift
//  RandomUser
//
//  Created by Toni on 03/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import KIF
import Nimble
import UIKit
@testable import RandomUser

class UsersViewControllerTest: AcceptanceTestCase {
  
  var usersRichModel = MockUsersRichModel()
  
  func testShowsEmptyCaseIfThereAreNoUsers() {
    givenThereAreNoUsers()
    
    openUsersViewController()
    
    tester().waitForView(withAccessibilityLabel: "No results found")
  }
  
  func testShowsUserNamesIfThereAreUsers() {
    let users = givenThereAreSomeUsers()
    
    openUsersViewController()
    
    for i in 0..<users.count {
      let userCell = tester().waitForView(withAccessibilityLabel: users[i].username) as! UserTableViewCell
      
      expect(userCell.nameLabel.text).to(equal(users[i].displayName))
    }
  }
  
  func testDoNotShowEmptyCaseIfThereAreUSers() {
    _ = givenThereAreSomeUsers()
    
    openUsersViewController()
    
    tester().waitForAbsenceOfView(withAccessibilityLabel: "No results found")
  }
  
  func testDoNotShowLoadingViewIfThereAreSomeUsers() {
    _ = givenThereAreSomeUsers()
    
    openUsersViewController()
    
    tester().waitForAbsenceOfView(withAccessibilityLabel: "LoadingView")
  }
  
  func testShowsTheExactNumberOfUsers() {
    let users = givenThereAreSomeUsers()
    
    openUsersViewController()
    
    let tableView = tester().waitForView(withAccessibilityLabel: "UsersTableView") as! UITableView
    expect(tableView.numberOfRows(inSection: 0)).to(equal(users.count))
  }
  
  func testOpensUserDetailViewControllerOnUserTapped() {
    let userIndex = 1
    let users = givenThereAreSomeUsers()
    let user = users[userIndex]
    
    openUsersViewController()
    
    tester().waitForView(withAccessibilityLabel: user.username)
    tester().tapRow(at: IndexPath(row: userIndex, section: 0),
                    inTableViewWithAccessibilityIdentifier: "UsersTableView")
    
    tester().waitForView(withAccessibilityLabel: user.username)
  }
  
  func testUserIsDeletedWhenRowDeleteBottomIsTapped() {
    let userIndex = 1
    let users = givenThereAreSomeUsers()
    let user = users[userIndex]
    
    openUsersViewController()
    
    tester().waitForView(withAccessibilityLabel: user.username)
    tester().swipeView(withAccessibilityLabel: user.username, in:KIFSwipeDirection.left)
    tester().waitForView(withAccessibilityLabel: "Delete")
    tester().tapView(withAccessibilityLabel: "Delete")
    tester().waitForAbsenceOfView(withAccessibilityLabel: user.username)
  }
  
  // MARK: - Helpers
  
  fileprivate func givenThereAreNoUsers() {
    _ = givenThereAreSomeUsers(0)
  }
  
  fileprivate func givenThereAreSomeUsers(_ numberOfUsers: Int = 10) -> [User] {
    var users = [User]()
    for i in 0..<numberOfUsers {
      let user = FakeUserMother.aUserWithIndex(i)
      users.append(user)
    }
    usersRichModel.users = users
    return users
  }

  fileprivate func givenAUser() -> User {
    let fakeUser = FakeUserMother.anyUser()
    usersRichModel.users = [fakeUser]
    return fakeUser
  }
  
  fileprivate func openUsersViewController() {
    let serviceLocator = ServiceLocator()
    serviceLocator.usersRichModel = usersRichModel
    
    let usersViewController = serviceLocator.provideUsersViewController() as! UsersViewController
    
    usersViewController.presenter = UsersPresenter(ui: usersViewController,
                                                   getUsers: GetUsers(richModel: usersRichModel),
                                                   getUsersByQuery: GetUsersByQuery(richModel: usersRichModel),
                                                   deleteUser: DeleteUser(richModel: usersRichModel))
    
    let rootViewController = UINavigationController()
    rootViewController.viewControllers = [usersViewController]
    present(viewController: rootViewController)
    tester().waitForAnimationsToFinish()
  }
}
