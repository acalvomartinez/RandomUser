//
//  UserDTO.swift
//  RandomUser
//
//  Created by Antonio Calvo on 28/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation

enum Gender: String {
  case male
  case female
}

struct UserDTO {
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let gender: Gender
    let location: LocationDTO
    let picture: PictureDTO
    let registeredAt: Date
}

extension UserDTO: JSONDecodable {
  init?(dictionary: JSONDictionary) {
    guard
      let nameJSON = dictionary["name"] as? JSONDictionary,
      let firstName = nameJSON["first"] as? String,
      let lastName = nameJSON["last"] as? String,
      let genderString = dictionary["gender"] as? String,
      let gender = Gender(rawValue: genderString),
      let email = dictionary["email"] as? String,
      let phone = dictionary["phone"] as? String,
      let locationJSON = dictionary["location"] as? JSONDictionary,
      let location: LocationDTO = JSONDecoder.decode(locationJSON),
      let pictureJSON = dictionary["picture"] as? JSONDictionary,
      let picture: PictureDTO = JSONDecoder.decode(pictureJSON),
      let restisteredString = dictionary["registered"] as? String,
      let registered = Date.parse(restisteredString)
      else {
        return nil
    }
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.phone = phone
    self.gender = gender
    self.location = location
    self.picture = picture
    self.registeredAt = registered
  }
}