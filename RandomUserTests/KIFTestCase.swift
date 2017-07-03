//
//  KIFTestCase.swift
//  RandomUser
//
//  Created by Toni on 03/07/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import Foundation
import KIF

extension KIFTestActor {
  func tester(_ file: String = #file, line: Int = #line) -> KIFUITestActor {
    return KIFUITestActor(inFile: file, atLine: line, delegate: self)
  }
  
  func system(_ file: String = #file, line: Int = #line) -> KIFSystemTestActor {
    return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
  }
}
