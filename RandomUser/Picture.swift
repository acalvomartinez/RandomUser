//
//  Picture.swift
//  RandomUser
//
//  Created by Antonio Calvo on 28/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation

enum PictureSize {
  case large
  case medium
  case thumbnail
}

struct Picture {
    let large: String
    let medium: String
    let thumbnail: String
}

extension Picture {
  func pictureURL(size: PictureSize) -> URL? {
    switch size {
    case .large:
      return URL(string: self.large)
    case .medium:
      return URL(string: self.medium)
    case .thumbnail:
      return URL(string: self.thumbnail)
    }
  }
}

extension Picture: JSONDecodable {
  init?(dictionary: JSONDictionary) {
    guard
      let large = dictionary["large"] as? String,
      let medium = dictionary["medium"] as? String,
      let thumbnail = dictionary["thumbnail"] as? String
      else {
        return nil
    }
    self.large = large
    self.medium = medium
    self.thumbnail = thumbnail
  }
}

extension Picture: Equatable { }

func == (lhs: Picture, rhs: Picture) -> Bool {
  return lhs.large == lhs.large
}
