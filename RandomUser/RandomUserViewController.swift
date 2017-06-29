//
//  RandomUserViewController.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

class RandomUserViewController: BothamViewController, BothamLoadingViewController {
    let loadingView: UIView = {
        let loadingView = BothamLoadingView()
        loadingView.color = UIColor.loadingColor
        return loadingView
    }()
}
