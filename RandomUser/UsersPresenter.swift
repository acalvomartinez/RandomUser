//
//  UsersPresenter.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

class UsersPresenter: BothamPresenter, BothamNavigationPresenter {
    fileprivate weak var ui: UsersUI?
    
    init(ui: UsersUI) {
        self.ui = ui
    }
    
    func viewDidLoad() {
        
    }
    
    func itemWasTapped(_ item: UsersListItem) {
        
    }
}

protocol UsersUI: BothamUI, BothamLoadingUI {

}
