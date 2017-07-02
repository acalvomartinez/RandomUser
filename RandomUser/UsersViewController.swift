//
//  UsersViewController.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

class UsersViewController: RandomUserViewController, BothamTableViewController, UsersUI {
  
  @IBOutlet weak var tableView: UITableView!
  
  var dataSource: UsersTableViewDataSource<UserListItemViewModel, UserTableViewCell>!
  var delegate: UITableViewDelegate!
  
  let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    self.title = "Random Users"
    
    tableView.dataSource = dataSource
    tableView.delegate = delegate
    tableView.tableFooterView = UIView()
    tableView.accessibilityLabel = "UsersTableView"
    tableView.accessibilityIdentifier = "UsersTableView"
    
    tableView.separatorColor = UIColor.secondaryTextColor
    tableView.backgroundColor = UIColor.cellBackgroundColor
    
    configureSearchController()
    
    configureNavigationBarBackButton()
    
    super.viewDidLoad()
  }
  
  func openUserDetailScreen(_ userDetailViewController: UIViewController) {
    navigationController?.push(viewController: userDetailViewController)
  }
  
  fileprivate func configureSearchController() {
    searchController.searchResultsUpdater = presenter as? UISearchResultsUpdating
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    tableView.tableHeaderView = searchController.searchBar
  }
  
  fileprivate func configureNavigationBarBackButton() {
    navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
  }
}

protocol UsersUI: BothamUI, BothamLoadingUI, EmptyResultUI {
  func show(items: [UserListItemViewModel])
  func showError(_ errorMessage: String)
  func openUserDetailScreen(_ userDetailViewController: UIViewController)
}
