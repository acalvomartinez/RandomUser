//
//  UsersInfiniteScrollPresenter.swift
//  RandomUser
//
//  Created by Toni on 02/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

public protocol UsersListPresenter: BothamNavigationPresenter {
  associatedtype ItemType
  func loadMoreData()
  func delete(_ item: ItemType)
}
