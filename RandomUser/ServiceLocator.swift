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
  func provideRootViewController() -> UIViewController {
    let navigationController: UINavigationController = storyBoard.initialViewController()
    navigationController.viewControllers = [provideUserViewController()]
    return navigationController
  }
  
  // MARK: - Private
  
  fileprivate func provideUserViewController() -> UIViewController {
    let usersViewController: UsersViewController = storyBoard.instantiateViewController("UsersViewController")
    let presenter = provideUsersPresenter(ui: usersViewController)
    let dataSource = provideUsersDataSource()
    usersViewController.presenter = presenter
    usersViewController.dataSource = dataSource
    usersViewController.delegate = UsersTableViewDelegate(dataSource: dataSource, presenter: presenter)
    usersViewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
    return usersViewController
  }
  
  fileprivate func provideUsersPresenter(ui: UsersUI) -> UsersPresenter {
    let usersRepository = UsersRepository(randomUserAPIClient: APIClient.randomUserAPIClient())
    let usersRichModel = UsersRichModel(repository: usersRepository, usersFilter: UsersFilter(), deletedUsernames: UserDefaultsDeletedUsernames())
    let getUsers = GetUsers(richModel: usersRichModel)
    return UsersPresenter(ui: ui, getUsers: getUsers)
  }
  
  fileprivate func provideUsersDataSource() -> BothamTableViewDataSource<User, UserTableViewCell> {
    return BothamTableViewDataSource<User, UserTableViewCell>()
  }
  
  fileprivate lazy var storyBoard: BothamStoryboard = {
    return BothamStoryboard(name: "RandomUser")
  }()
}
