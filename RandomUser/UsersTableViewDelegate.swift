//
//  TableViewDelegate.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

class UsersTableViewDelegate<T: BothamViewDataSource, U: BothamNavigationPresenter>: BothamTableViewNavigationDelegate<T, U> where T.ItemType == U.ItemType {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
  }
}
