//
//  EmptyResultView.swift
//  RandomUser
//
//  Created by Toni on 01/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import BothamUI
import UIKit

@IBDesignable
public class EmptyResultView: BothamCustomView {
  @IBOutlet public weak var emptyLabel: UILabel! {
    didSet {
      emptyLabel.text = "No results found...\nSorry but this aren't the droids you're looking for."
      emptyLabel.accessibilityLabel = "No results found"
    }
  }
  
  @IBInspectable public var color: UIColor? = nil {
    didSet {
      emptyLabel.textColor = color
    }
  }
}
