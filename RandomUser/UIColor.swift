//
//  UIColor.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Antonio Calvo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  convenience init(rgba: String) {
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 1.0
    
    if rgba.hasPrefix("#") {
      let index   = rgba.characters.index(rgba.startIndex, offsetBy: 1)
      let hex     = rgba.substring(from: index)
      let scanner = Scanner(string: hex)
      var hexValue: CUnsignedLongLong = 0
      if scanner.scanHexInt64(&hexValue) {
        switch hex.characters.count {
        case 3:
          red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
          green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
          blue  = CGFloat(hexValue & 0x00F)              / 15.0
        case 4:
          red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
          green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
          blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
          alpha = CGFloat(hexValue & 0x000F)             / 15.0
        case 6:
          red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
          green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
          blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
        case 8:
          red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
          green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
          blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
          alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
        default:
          print("Invalid RGB string")
        }
      } else {
        print("Scan hex error")
      }
    } else {
      print("Invalid RGB string, missing '#' as prefix", terminator: "")
    }
    
    self.init(red:red, green:green, blue:blue, alpha:alpha)
  }
  
  static var windowBackgroundColor: UIColor {
    return UIColor(rgba: "#E63946FF")
  }
  
  static var loadingColor: UIColor {
    return UIColor(rgba: "#E63946FF")
  }
  
  static var navigationBarColor: UIColor {
    return UIColor(rgba: "#E63946FF")
  }
  
  static var navigationBarTitleColor: UIColor {
    return UIColor(rgba: "#F1FAEEFF")
  }
  
  static var cellBackgroundColor: UIColor {
    return UIColor(rgba: "#F1FAEEFF")
  }
  
  static var primaryTextColor: UIColor {
    return UIColor(rgba: "#1D3557FF")
  }
  
  static var secondaryTextColor: UIColor {
    return UIColor(rgba: "#457B9DFF")
  }
  
}
