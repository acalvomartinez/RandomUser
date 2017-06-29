//
//  APIClient.swift
//  RandomUser
//
//  Created by Toni on 28/06/2017.
//  Copyright © 2017 Antonio Calvo. All rights reserved.
//

import Foundation
import Result

final class APIClient {
  fileprivate let baseURL: URL
  fileprivate let session: URLSession
  
  init(baseURL: URL, configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
    self.baseURL = baseURL
    self.session = URLSession(configuration: configuration)
  }
  
  func object<T: JSONDecodable>(_ resource: Resource, completion: @escaping (Result<T, APIClientError>) -> Void) {
    data(resource: resource) { (result) in
      if let error = result.error {
        completion(Result(error: error))
        return
      }
      
      guard let object:T = JSONDecoder.decode(data: result.value!) else {
        completion(Result(error: .couldNotDecodeJSON))
        return
      }
      
      completion(Result(value: object))
    }
  }
  
  func objects<T: JSONDecodable>(_ resource: Resource, completion: @escaping (Result<[T], APIClientError>) -> Void) {
    data(resource: resource) { (result) in
      if let error = result.error {
        completion(Result(error: error))
        return
      }
      
      guard let objects:[T] = JSONDecoder.decode(data: result.value!) else {
        completion(Result(error: .couldNotDecodeJSON))
        return
      }
      
      completion(Result(value: objects))
    }
  }
  
  // MARK: - Private
  
  fileprivate func data(resource: Resource,
                        completion: @escaping (Result<Data, APIClientError>) -> Void) {
    
    let request = resource.requestWithBaseURL(baseURL: self.baseURL)
    
    let task = self.session.dataTask(with: request) { (data, response, error) in
      if let error = error {
        let clientError = APIClientError.build(error: error)
        completion(Result(error: clientError))
      } else {
        guard let httpResponse = response as? HTTPURLResponse else {
          completion(Result(error: .networkError))
          return
        }
        
        if 200 ..< 300 ~= httpResponse.statusCode {
          completion(Result(value: data ?? Data()))
        } else {
          completion(Result(error: .badStatus(status: httpResponse.statusCode)))
        }
      }
    }
    
    task.resume()
  }
}
