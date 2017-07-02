//
//  UserDetailViewController.swift
//  RandomUser
//
//  Created by Toni on 02/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import SDWebImage

class UserDetailViewController: RandomUserViewController, UserUI {
  
  @IBOutlet weak var profileImageView: UIImageView!
  
  @IBOutlet weak var displayNameLabel: UILabel!
  @IBOutlet weak var genderLabel: UILabel!
  
  @IBOutlet weak var streetLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var stateLabel: UILabel!
  
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  
  @IBOutlet weak var registerdAtLabel: UILabel!
  
  func show(user: User?) {
    guard let user = user else {
      return
    }
    
    profileImageView.sd_setImage(with: user.picture.pictureURL(size: .large))
    displayNameLabel.text = user.displayName
    displayNameLabel.accessibilityLabel = "Name: \(user.displayName)"
    genderLabel.text = user.gender.rawValue
    genderLabel.accessibilityLabel = "Gender: \(user.gender.rawValue)"
    streetLabel.text = user.location.street
    streetLabel.accessibilityLabel = "Street: \(user.location.street)"
    cityLabel.text = user.location.city
    cityLabel.accessibilityLabel = "City: \(user.location.city)"
    stateLabel.text = user.location.state
    stateLabel.accessibilityLabel = "State: \(user.location.state)"
    emailLabel.text = user.email
    emailLabel.accessibilityLabel = "Email: \(user.email)"
    phoneLabel.text = user.phone
    phoneLabel.accessibilityLabel = "Phone: \(user.phone)"
  }
}

protocol UserUI: BothamUI, BothamLoadingUI {
  func show(user: User?)
  func showError(_ errorMessage: String)
  var title: String? { get set }
}




