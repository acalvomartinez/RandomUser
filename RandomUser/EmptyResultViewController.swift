//
//  EmptyResultViewController.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI
import UIKit

protocol EmptyResultViewController: EmptyResultUI {
  var emptyResultView: UIView { get }
  var view: UIView! { get }
}

extension EmptyResultViewController {
  func showEmptyResult() {
    guard !view.subviews.contains(emptyResultView) else {
      return
    }
    
    emptyResultView.isHidden = false
    emptyResultView.frame = view.bounds
    emptyResultView.autoresizingMask = [
      .flexibleBottomMargin,
      .flexibleLeftMargin,
      .flexibleRightMargin,
      .flexibleTopMargin
    ]
    
    view.addSubview(emptyResultView)
  }
  
  func hideEmptyResult() {
    emptyResultView.removeFromSuperview()
    emptyResultView.isHidden = true
  }
}
