//
//  AppUITests.swift
//  AppUITests
//
//  Created by Khurram on 31/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest

class AppUITests: XCTestCase {

override func setUp() {
  continueAfterFailure = false
}

func testTopTitle() {
  let app = XCUIApplication()
  app.launch()
  app.buttons["Show Overlay"].tap()
  let exp = defaultExpectation()
  DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    if app.staticTexts["topTitle"].exists {
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 2)
}
func testBottomTitle() {
  let app = XCUIApplication()
  app.launch()
  app.buttons["Show Overlay"].tap()
  let exp = defaultExpectation()
  DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    if app.staticTexts["bottomTitle"].exists {
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 2)
}
}

extension XCTestCase {
func defaultExpectation(_ functionName: String = #function) -> XCTestExpectation {
  expectation(description: functionName)
}
} // extension XCTestCase
