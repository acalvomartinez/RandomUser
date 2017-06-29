//
//  RandomUserAPIClientTests.swift
//  RandomUser
//
//  Created by Toni on 29/06/2017.
//  Copyright © 2017 Antonio Calvo. All rights reserved.
//

import Foundation
import OHHTTPStubs
import Nimble
import XCTest
import Result

@testable import RandomUser

class RandomUserAPIClientTests: XCTestCase {
  fileprivate let randomUserAPIClient = APIClient.randomUserAPIClient()
  
  override func tearDown() {
    OHHTTPStubs.removeAllStubs()
  }
  
  func testReturnsGetUsersResponse() {
    let url = URL(string: RandomUserAPIClientConfiguration.baseEndpoint.appending(RandomUserAPIClientConfiguration.getUsersEndpoint))
    let path = url?.path
    stub(condition: isPath(path!)) { request in
      return OHHTTPStubsResponse(
        fileAtPath: OHPathForFile("getUsersResponse.json", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/json"]
      )
    }
    
    var result: Result<GetUsersDTO, RandomUserAPIClientError>?
    
    randomUserAPIClient.getUsers(results: 10, page: 1) { (response) in
      result = response
    }
    expect(result).toEventuallyNot(beNil())
    assertContainsExpectedGetCharactersDTO(getUsersDTO: result?.value)
  }
  
  func testReturnsNetworkErrorIfThereIsNoConnectionGettingUsers() {
    let url = URL(string: RandomUserAPIClientConfiguration.baseEndpoint.appending(RandomUserAPIClientConfiguration.getUsersEndpoint))
    let path = url?.path
    stub(condition: isPath(path!)) { request in
      return OHHTTPStubsResponse(error: NSError.networkError())
    }
    
    var result: Result<GetUsersDTO, RandomUserAPIClientError>?
    
    randomUserAPIClient.getUsers(results: 10, page: 1) { (response) in
      result = response
    }
    expect(result?.error).toEventually(equal(RandomUserAPIClientError.networkError))
  }
  
  func testReturnsEmptyListIfResultIsEmpty() {
    let url = URL(string: RandomUserAPIClientConfiguration.baseEndpoint.appending(RandomUserAPIClientConfiguration.getUsersEndpoint))
    let path = url?.path
    stub(condition: isPath(path!)) { request in
      return OHHTTPStubsResponse(
        fileAtPath: OHPathForFile("getUsersEmptyResponse.json", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/json"]
      )
    }
    
    var result: Result<GetUsersDTO, RandomUserAPIClientError>?
    
    randomUserAPIClient.getUsers(results: 10, page: 1) { (response) in
      result = response
    }
    expect(result).toEventuallyNot(beNil())
    expect(result?.value?.users?.count).to(equal(0))
  }
  
  func testReturnsErrorIfServerReturn404Error() {
    let url = URL(string: RandomUserAPIClientConfiguration.baseEndpoint.appending(RandomUserAPIClientConfiguration.getUsersEndpoint))
    let path = url?.path
    stub(condition: isPath(path!)) { request in
      return OHHTTPStubsResponse(
        fileAtPath: OHPathForFile("error.json", type(of: self))!,
        statusCode: 404,
        headers: ["Content-Type": "application/json"]
      )
    }
    
    var result: Result<GetUsersDTO, RandomUserAPIClientError>?
    
    randomUserAPIClient.getUsers(results: 10, page: 1) { (response) in
      result = response
    }
    expect(result?.error).toEventually(equal(RandomUserAPIClientError.itemNotFound))
  }
  
  func testReturnsErrorWhenServerCrash() {
    let url = URL(string: RandomUserAPIClientConfiguration.baseEndpoint.appending(RandomUserAPIClientConfiguration.getUsersEndpoint))
    let path = url?.path
    stub(condition: isPath(path!)) { request in
      return OHHTTPStubsResponse(error: NSError.crashError())
    }
    
    var result: Result<GetUsersDTO, RandomUserAPIClientError>?
    
    randomUserAPIClient.getUsers(results: 10, page: 1) { (response) in
      result = response
    }
    expect(result?.error).toEventually(equal(RandomUserAPIClientError.internalServerDrama))
  }

  // MARK: - Private
  
  fileprivate func assertContainsExpectedGetCharactersDTO(getUsersDTO: GetUsersDTO?) {
    expect(getUsersDTO).toNot(beNil())
    expect(getUsersDTO?.results).to(equal(10))
    expect(getUsersDTO?.page).to(equal(1))
    expect(getUsersDTO?.users).toNot(beNil())
    expect(getUsersDTO?.users?.count).to(equal(10))

    assertContainsExpectedUserDTO(userDTO: getUsersDTO?.users?[0])
  }
  
  fileprivate func assertContainsExpectedUserDTO(userDTO: UserDTO?) {
    expect(userDTO?.username).to(equal("silvergorilla792"))
    expect(userDTO?.firstName).to(equal("juho"))
    expect(userDTO?.lastName).to(equal("luoma"))
    expect(userDTO?.email).to(equal("juho.luoma@example.com"))
    expect(userDTO?.phone).to(equal("07-205-701"))
    expect(userDTO?.gender).to(equal(.male))
    expect(userDTO?.location.street).to(equal("2566 pirkankatu"))
    expect(userDTO?.location.city).to(equal("janakkala"))
    expect(userDTO?.location.state).to(equal("northern ostrobothnia"))
    expect(userDTO?.picture.large).to(equal("https://randomuser.me/api/portraits/men/30.jpg"))
    expect(userDTO?.picture.medium).to(equal("https://randomuser.me/api/portraits/med/men/30.jpg"))
    expect(userDTO?.picture.thumbnail).to(equal("https://randomuser.me/api/portraits/thumb/men/30.jpg"))
    expect(userDTO?.registeredAt.toString()).to(equal("2014-07-17 00:32:18"))
  }
}
