//
//  Resource.swift
//  RandomUser
//
//  Created by Toni on 28/06/2017.
//  Copyright © 2017 Antonio Calvo. All rights reserved.
//

import Foundation

enum Method: String {
  case GET = "GET"
  case POST = "POST"
  case PATCH = "PATCH"
  case PUT = "PUT"
  case DELETE = "DELETE"
}

protocol Resource {
  var method: Method { get }
  var path: String { get }
  var parameters: [String: String] { get }
}


extension Resource {
  var method: Method {
    return .GET
  }
  
  func requestWithBaseURL(baseURL: URL) -> URLRequest {
    let url = baseURL.appendingPathComponent(path)
    
    guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      fatalError("Unable to create URL components from \(url)")
    }
    
    components.queryItems = parameters.map {
      URLQueryItem(name: String($0), value: String($1))
    }
    
    guard let finalURL = components.url else {
      fatalError("Unable to retrieve final URL")
    }
    
    var request = URLRequest(url: finalURL)
    request.httpMethod = method.rawValue
    
    return request
  }
}
