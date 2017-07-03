//
//  ServiceLocator.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import UIKit
import BothamUI

class ServiceLocator {
  static let sharedInstance = ServiceLocator()
  
  func provideRootViewController() -> UIViewController {
    let navigationController: UINavigationController = storyBoard.initialViewController()
    navigationController.viewControllers = [provideUsersViewController()]
    return navigationController
  }
  
  func provideUserDetailViewController(_ username: String) -> UIViewController {
    let viewController: UserDetailViewController = storyBoard.instantiateViewController("UserDetailViewController")
    let getUserDetail = GetUserDetail(richModel: usersRichModel)
    let presenter = UserDetailPresenter(username: username, ui: viewController, getUserDetail: getUserDetail)
    viewController.presenter = presenter
    return viewController
  }
  
  func provideUsersViewController() -> UIViewController {
    let usersViewController: UsersViewController = storyBoard.instantiateViewController("UsersViewController")
    let presenter = provideUsersPresenter(ui: usersViewController)
    let dataSource = UsersTableViewDataSource<UserListItemViewModel, UserTableViewCell>()
    usersViewController.presenter = presenter
    usersViewController.dataSource = dataSource
    usersViewController.delegate = UsersTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
    return usersViewController
  }
  
  // MARK: - Private

  fileprivate func provideUsersPresenter(ui: UsersUI) -> UsersPresenter {
    let getUsers = GetUsers(richModel: usersRichModel)
    let getUsersByQuery = GetUsersByQuery(richModel: usersRichModel)
    let deleteUser = DeleteUser(richModel: usersRichModel)
    return UsersPresenter(ui: ui, getUsers: getUsers, getUsersByQuery: getUsersByQuery, deleteUser: deleteUser)
  }
  
  fileprivate lazy var usersRichModel: UsersRichModel = {
    let usersRepository = UsersRepository(randomUserAPIClient: APIClient.randomUserAPIClient())
    let usersRichModel = UsersRichModel(repository: usersRepository, usersFilter: UsersFilter(), deletedUsernames: UserDefaultsDeletedUsernames())
    
    return usersRichModel
  }()
  
  fileprivate lazy var storyBoard: BothamStoryboard = {
    return BothamStoryboard(name: "RandomUser")
  }()
}
