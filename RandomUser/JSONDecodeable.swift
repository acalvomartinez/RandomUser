//
//  JSONDecodeable.swift
//  RandomUser
//
//  Created by Toni on 28/06/2017.
//  Copyright © 2017 Antonio Calvo. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

protocol JSONDecodable {
  init?(dictionary: JSONDictionary)
}

final class JSONDecoder {
  public static func decode<T: JSONDecodable>(_ dictionaries: [JSONDictionary]) -> [T]? {
    return dictionaries.flatMap { T(dictionary: $0) }
  }
  
  public static func decode<T: JSONDecodable>(_ dictionary: JSONDictionary) -> T? {
    return T(dictionary: dictionary)
  }
  
  public static func decode<T: JSONDecodable>(data: Data) -> T? {
    guard let JSONObject = try? JSONSerialization.jsonObject(with: data, options: []),
      let dictionary = JSONObject as? JSONDictionary,
      let object: T = decode(dictionary) else {
        return nil
    }
    return object
  }
  
  public static func decode<T: JSONDecodable>(data: Data) -> [T]? {
    guard let JSONObject = try? JSONSerialization.jsonObject(with: data, options: []),
      let dictionaries = JSONObject as? [JSONDictionary],
      let objects: [T] = decode(dictionaries) else {
        return nil
    }
    return objects
  }
}
