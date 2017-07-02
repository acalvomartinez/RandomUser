//
//  UserTableViewCell.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import SDWebImage

class UserTableViewCell: UITableViewCell, BothamViewCell {
  
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.photoImageView.layer.cornerRadius = self.photoImageView.bounds.size.width/2
    self.photoImageView.clipsToBounds = true
    
    self.backgroundColor = UIColor.cellBackgroundColor
    self.nameLabel.textColor = UIColor.primaryTextColor
    self.emailLabel.textColor = UIColor.secondaryTextColor
    self.phoneLabel.textColor = UIColor.secondaryTextColor
  }
  
  func configure(forItem item: UserListItemViewModel) {
    nameLabel.text = item.displayName
    emailLabel.text = item.email
    phoneLabel.text = item.phone
    
    photoImageView.sd_setImage(with: item.photo)
    
    accessibilityLabel = item.username
  }
}
