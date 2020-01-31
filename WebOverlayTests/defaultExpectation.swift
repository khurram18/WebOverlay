//
//  defaultExpectation.swift
//  WebOverlayTests
//
//  Created by Khurram on 31/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
func defaultExpectation(_ functionName: String = #function) -> XCTestExpectation {
  expectation(description: functionName)
}
} // extension XCTestCase
