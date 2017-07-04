//
//  RandomUserViewController.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI

class RandomUserViewController: BothamViewController, BothamLoadingViewController, EmptyResultViewController {
  let loadingView: UIView = {
    let loadingView = BothamLoadingView()
    loadingView.color = UIColor.loadingColor
    return loadingView
  }()
  
  let emptyResultView: UIView = {
    let emptyResultView = EmptyResultView()
    emptyResultView.color = UIColor.loadingColor
    return emptyResultView
  }()
  
  func showError(_ errorMessage: String) {
    let alert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
