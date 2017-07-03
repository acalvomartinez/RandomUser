//
//  UserDetailViewControllerTest.swift
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

class UserDetailViewControllerTest: AcceptanceTestCase {
  
  var usersRichModel: MockUsersRichModel?
  
  override func setUp() {
    super.setUp()
    let mockUsersAPIClient = MockUsersAPIClient()
    let fakeRepository = UsersRepository(randomUserAPIClient: mockUsersAPIClient)
    
    usersRichModel = MockUsersRichModel(repository: fakeRepository)
  }
  
  func testShowsUsernameAsTitle() {
    let user = givenAUser()
    
    openUserDetailViewController(user.username)
    
    tester().waitForView(withAccessibilityLabel: user.username)
  }
  
  func testShowsUserInfo() {
    let user = givenAUser()
    
    openUserDetailViewController(user.username)
    
    assertUserExpectedValues(user)
  }
  
  fileprivate func assertUserExpectedValues(_ user: User) {
    tester().waitForView(withAccessibilityLabel: "Name: \(user.displayName)")
    tester().waitForView(withAccessibilityLabel: "Gender: \(user.gender.rawValue)")
    tester().waitForView(withAccessibilityLabel: "Street: \(user.location.street)")
    tester().waitForView(withAccessibilityLabel: "City: \(user.location.city)")
    tester().waitForView(withAccessibilityLabel: "State: \(user.location.state)")
    tester().waitForView(withAccessibilityLabel: "Email: \(user.email)")
    tester().waitForView(withAccessibilityLabel: "Phone: \(user.phone)")
    tester().waitForView(withAccessibilityLabel: "Registered: \(user.registeredAt.toString())")
  }
  
  
  fileprivate func givenAUser() -> User {
    let fakeUser = FakeUserMother.anyUser()
    usersRichModel!.users = [fakeUser]
    return fakeUser
  }
  
  fileprivate func openUserDetailViewController(_ username: String) {
    let userDetailViewController = ServiceLocator().provideUserDetailViewController(username) as! UserDetailViewController
    userDetailViewController.presenter = UserDetailPresenter(username: username,
                                                             ui: userDetailViewController,
                                                             getUserDetail: GetUserDetail(richModel: usersRichModel!))
    
    let rootViewController = UINavigationController()
    rootViewController.viewControllers = [userDetailViewController]
    present(viewController: rootViewController)
    tester().waitForAnimationsToFinish()
  }
}
