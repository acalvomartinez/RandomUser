//
//  NSError.swift
//  gasolinapp
//
//  Created by Toni on 27/05/2017.
//  Copyright © 2017 Unagi Studio. All rights reserved.
//

import Foundation

extension NSError {
  static func networkError() -> NSError {
    return NSError(domain: NSURLErrorDomain,
                   code: NSURLErrorNetworkConnectionLost,
                   userInfo: nil)
  }
  
  static func crashError() -> NSError {
    return NSError(domain: NSURLErrorDomain,
                   code: 500,
                   userInfo: nil)
  }
  
  static func notFoundError() -> NSError {
    return NSError(domain: NSURLErrorDomain,
                   code: 404,
                   userInfo: nil)
  }
}
