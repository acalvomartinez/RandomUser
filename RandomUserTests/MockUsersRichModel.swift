//
//  MockUsersRichModel.swift
//  RandomUser
//
//  Created by Toni on 03/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import Result

@testable import RandomUser

class MockUsersRichModel: UsersRichModel {
  var users = [User]()

  override func getDetail(withUsername username: String, _ completion: @escaping (Result<UserViewModel, UsersError>) -> ()) {
    let userByName = users.filter { $0.username == username }.first!
    
    let userViewModel = UserViewModel(username: userByName.username,
                                      displayName: userByName.displayName,
                                      gender: userByName.gender.rawValue,
                                      street: userByName.location.street,
                                      city: userByName.location.city,
                                      state: userByName.location.state,
                                      registeredAt: userByName.registeredAt.toString(),
                                      email: userByName.email,
                                      phone: userByName.phone,
                                      photo: userByName.picture.pictureURL(size: .large))
    
    completion(Result(value:userViewModel))
  }
}
