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
        
        
        
        return UIViewController()
    }
    
    
    fileprivate lazy var storyBoard: BothamStoryboard = {
        return BothamStoryboard(name: "RandomUser")
    }()
}
