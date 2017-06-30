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
    
    func configure(forItem item: User) {
        nameLabel.text = item.displayName
        emailLabel.text = item.email
        phoneLabel.text = item.phone
        
        let urlPicture = item.picture.pictureURL(size: .large)
        photoImageView.sd_setImage(with: urlPicture)
        
        accessibilityLabel = item.username
    }
}
