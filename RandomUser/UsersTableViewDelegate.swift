//
//  TableViewDelegate.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

open class UsersTableViewNavigationDelegate<T: BothamViewDataSource, U: UsersListPresenter>: NSObject, UITableViewDelegate where T.ItemType == U.ItemType {
  fileprivate let dataSource: T
  fileprivate let presenter: U
  
  fileprivate var itemEditing: Int? = nil
  
  public init(dataSource: T, presenter: U) {
    self.dataSource = dataSource
    self.presenter = presenter
  }
  
  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = dataSource.item(at: indexPath)
    presenter.itemWasTapped(item)
  }
  
  public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
    itemEditing = indexPath.item
  }
  
  public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let itemSelected = itemEditing else {
      return
    }
    if (itemSelected == indexPath.item) {
      let item = dataSource.item(at: indexPath)
      presenter.delete(item)
      itemEditing = nil
    }
  }
  
  open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if (indexPath.item == dataSource.items.count-1) {
      presenter.loadMoreData()
    }
  }
}
