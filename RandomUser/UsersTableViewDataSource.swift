//
//  UsersTableViewDataSource.swift
//  RandomUser
//
//  Created by Toni on 02/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

public class UsersTableViewDataSource<U, V: BothamViewCell>: NSObject, UITableViewDataSource, BothamViewDataSource where U == V.ItemType {
  public var items = [U]()
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: V.identifier, for: indexPath)
    let item = self.item(at: indexPath)
    (cell as! V).configure(forItem: item)
    return cell
  }
  
  public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == .delete) {
      items.remove(at: indexPath.item)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
}

extension BothamViewDataSource {
  mutating func remove(itemAt index: Int) {
    items.remove(at: index)
  }
}

