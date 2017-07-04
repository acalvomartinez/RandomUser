//
//  APIClientTests.swift
//  RandomUser
//
//  Created by Toni on 29/06/2017.
//  Copyright © 2017 Antonio Calvo. All rights reserved.
//

import Foundation
import OHHTTPStubs
import Nimble
import Result
import XCTest


@testable import RandomUser

class APIClientTests: XCTestCase {
  struct TestModel: JSONDecodable {
    let foo: String
    
    init?(dictionary: JSONDictionary) {
      guard let foo = dictionary["foo"] as? String else {
        return nil
      }
      
      self.foo = foo
    }
  }
  
  struct TestResource: Resource {
    let path: String = "object"
    let parameters: [String: String] = ["testing": "true"]
  }
  
  struct TestResources: Resource {
    let path: String = "objects"
    let parameters: [String: String] = ["testing": "true"]
  }
  
  fileprivate let client = APIClient(baseURL: URL(string: "http://test.com")!)
  
  override func tearDown() {
    OHHTTPStubs.removeAllStubs()
  }
  
  func testParsesResourcesProperlyGettingResources() {
    stub(condition: isHost("test.com")) { request in
      return OHHTTPStubsResponse(
        fileAtPath: OHPathForFile("resources.json", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/json"]
      )
    }
    
    let resource = TestResources()
    var result: Result<[TestModel], APIClientError>?
    
    client.objects(resource) { (response) in
      result = response
    }
    
    expect(result?.value?.count).toEventually(equal(2))
  }
  
  func testParsesResourceProperlyGettingAResource() {
    stub(condition: isHost("test.com")) { request in
      return OHHTTPStubsResponse(
        fileAtPath: OHPathForFile("resource.json", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/json"]
      )
    }
    
    let resource = TestResource()
    var result: Result<TestModel, APIClientError>?
    
    client.object(resource) { (response) in
      result = response
    }
    
    expect(result?.value?.foo).toEventually(equal("foo"))
  }
  
  func testReturnsNetworkErrorIfThereIsNoConnectionGettingAllTasks() {
    stub(condition: isHost("test.com")) { request in
      return OHHTTPStubsResponse(error: NSError.networkError())
    }
    
    let resource = TestResource()
    var result: Result<TestModel, APIClientError>?
    
    client.object(resource) { response in
      result = response
    }
    
    expect(result?.error).toEventually(equal(APIClientError.networkError))
  }
  
  func testReturnsEmptyListIfResultIsEmpty() {
    stub(condition: isHost("test.com")) { request in
      return OHHTTPStubsResponse(
        fileAtPath: OHPathForFile("emptyResources.json", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/json"]
      )
    }
    
    let resource = TestResources()
    var result: Result<[TestModel], APIClientError>?
    
    client.objects(resource) { (response) in
      result = response
    }
    
    expect(result?.value?.count).toEventually(equal(0))
  }
  
}
