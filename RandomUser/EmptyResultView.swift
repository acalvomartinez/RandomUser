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
open class EmptyResultView: BothamCustomView {
  @IBOutlet open weak var emptyLabel: UILabel! {
    didSet {
      emptyLabel.text = "No results found...\nSorry but this aren't the droids you're looking for."
    }
  }
  
  @IBInspectable open var color: UIColor? = nil {
    didSet {
      emptyLabel.textColor = color
    }
  }
}
