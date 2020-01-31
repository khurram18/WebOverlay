//
//  OverlayViewModelTests.swift
//  WebOverlayTests
//
//  Created by Khurram on 31/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest

final class InValidAdInfo: AdInfo {
  
var advertisingIdentifier: UUID? {
  nil
}
  
} // class InValidAdInfo

final class ValidAdInfo: AdInfo {
  
private let uuid = UUID()
  
var advertisingIdentifier: UUID? {
  uuid
}
  
} // class ValidAdInfo

final class CloseHelper: CloseDelegate {
let expectation: XCTestExpectation
let fulFillOnError: Bool
init(expectation: XCTestExpectation, fulFillOnError: Bool) {
  self.expectation = expectation
  self.fulFillOnError = fulFillOnError
}
  
func close(error: Error?, completion: (() -> Void)?) {
  if fulFillOnError {
    if error != nil {
      expectation.fulfill()
    }
  } else {
    expectation.fulfill()
  }
} // class CloseHelper
  
}
final class OverlayViewModelTests: XCTestCase {
  
var closeDelegates = [CloseDelegate]()
var observers = [NSKeyValueObservation]()
  
override func setUp() {
}

func testInValidAdInfo() {
  let exp = defaultExpectation()
  let closeHelper = CloseHelper(expectation: exp, fulFillOnError: false)
  let sut = OverlayViewModel(adInfo: InValidAdInfo(), closeDelegate: closeHelper)
  sut.start()
  closeDelegates.append(closeHelper)
  wait(for: [exp], timeout: 2)
}
  
func testValidAdInfo() {
  let exp = defaultExpectation()
  let closeHelper = CloseHelper(expectation: exp, fulFillOnError: true)
  let sut = OverlayViewModel(adInfo: ValidAdInfo(), closeDelegate: closeHelper)
  sut.start()
  closeDelegates.append(closeHelper)
  wait(for: [exp], timeout: 2)
}
  
func testTopTitle() {
  let exp = defaultExpectation()
  let sut = OverlayViewModel(adInfo: ValidAdInfo(), closeDelegate: CloseHelper(expectation: exp, fulFillOnError: false))
  sut.options = testStartOptions
  let observer = sut.observe(\OverlayViewModel.topTitle, options: [.new, .initial]) { _, change in
    if change.newValue == "topTitle" {
      exp.fulfill()
    }
  }
  observers.append(observer)
  sut.start()
  wait(for: [exp], timeout: 1)
}
func testBottomTitle() {
  let exp = defaultExpectation()
  let sut = OverlayViewModel(adInfo: ValidAdInfo(), closeDelegate: CloseHelper(expectation: exp, fulFillOnError: false))
  sut.options = testStartOptions
  let observer = sut.observe(\OverlayViewModel.bottomTitle, options: [.new, .initial]) { _, change in
    if change.newValue == "bottomTitle" {
      exp.fulfill()
    }
  }
  observers.append(observer)
  sut.start()
  wait(for: [exp], timeout: 1)
}
func testCloseImageName() {
  let exp = defaultExpectation()
  let sut = OverlayViewModel(adInfo: ValidAdInfo(), closeDelegate: CloseHelper(expectation: exp, fulFillOnError: false))
  sut.options = testStartOptions
  let observer = sut.observe(\OverlayViewModel.closeImageName, options: [.new, .initial]) { _, change in
    if change.newValue == "closeButtonImageName" {
      exp.fulfill()
    }
  }
  observers.append(observer)
  sut.start()
  wait(for: [exp], timeout: 1)
}
} // class OverlayViewModelTests
