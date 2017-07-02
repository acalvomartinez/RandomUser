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
  
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var streetLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var stateLabel: UILabel!
  
  @IBOutlet weak var contactLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  
  @IBOutlet weak var registeredLabel: UILabel!
  @IBOutlet weak var registeredDateLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.detailBackgroundColor
    addressLabel.text = "Address"
    displayNameLabel.textColor = UIColor.clearTextColor
    genderLabel.textColor = UIColor.clearTextColor
    addressLabel.textColor = UIColor.primaryTextColor
    streetLabel.textColor = UIColor.primaryTextColor
    cityLabel.textColor = UIColor.primaryTextColor
    stateLabel.textColor = UIColor.primaryTextColor
    contactLabel.text = "Contact"
    contactLabel.textColor = UIColor.primaryTextColor
    emailLabel.textColor = UIColor.primaryTextColor
    phoneLabel.textColor = UIColor.primaryTextColor
    registeredLabel.text = "Registered since"
    registeredLabel.textColor = UIColor.primaryTextColor
    registeredDateLabel.textColor = UIColor.secondaryTextColor
  }
  
  func show(user: UserViewModel?) {
    guard let user = user else {
      return
    }
    
    profileImageView.sd_setImage(with: user.photo)
    displayNameLabel.text = user.displayName
    displayNameLabel.accessibilityLabel = "Name: \(user.displayName)"
    genderLabel.text = user.gender
    genderLabel.accessibilityLabel = "Gender: \(user.gender)"
    streetLabel.text = user.street
    streetLabel.accessibilityLabel = "Street: \(user.street)"
    cityLabel.text = user.city
    cityLabel.accessibilityLabel = "City: \(user.city)"
    stateLabel.text = user.state
    stateLabel.accessibilityLabel = "State: \(user.state)"
    emailLabel.text = user.email
    emailLabel.accessibilityLabel = "Email: \(user.email)"
    phoneLabel.text = user.phone
    phoneLabel.accessibilityLabel = "Phone: \(user.phone)"
    registeredDateLabel.text = user.registeredAt
    registeredDateLabel.accessibilityLabel = "Registered: \(user.registeredAt)"
    
    applyImageGradient(profileImageView)
  }
  
  fileprivate func applyImageGradient(_ profileImage: UIImageView) {
    guard profileImage.layer.sublayers == nil else {
      return
    }
    let gradient: CAGradientLayer = CAGradientLayer(layer: profileImage.layer)
    gradient.frame = profileImage.bounds
    gradient.colors = [UIColor.gradientStartColor.cgColor, UIColor.gradientEndColor.cgColor]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.6)
    gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
    profileImage.layer.insertSublayer(gradient, at: 0)
  }
}

protocol UserUI: BothamUI, BothamLoadingUI {
  func show(user: UserViewModel?)
  func showError(_ errorMessage: String)
  var title: String? { get set }
}




