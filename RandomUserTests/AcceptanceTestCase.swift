//
//  AcceptanceTestCase.swift
//  RandomUser
//
//  Created by Toni on 03/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import KIF

class AcceptanceTestCase: KIFTestCase {
  
  fileprivate var originalRootViewController: UIViewController?
  fileprivate var rootViewController: UIViewController? {
    get {
      return UIApplication.shared.keyWindow?.rootViewController
    }
    
    set(newRootViewController) {
      UIApplication.shared.keyWindow?.rootViewController = newRootViewController
    }
  }
  
  override func tearDown() {
    super.tearDown()
    if let originalRootViewController = originalRootViewController {
      rootViewController = originalRootViewController
    }
  }
  
  func present(viewController: UIViewController) {
    originalRootViewController = rootViewController
    rootViewController = viewController
  }
}
