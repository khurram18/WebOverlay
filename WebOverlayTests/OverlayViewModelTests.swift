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

final class ErrorCloseHelper: CloseDelegate {
let expectation: XCTestExpectation
init(expectation: XCTestExpectation) {
  self.expectation = expectation
}
  
func close(error: Error?, completion: (() -> Void)?) {
  if error != nil {
    expectation.fulfill()
  }
}
} // class ErrorCloseHelper

final class MockCloseDelegate: CloseDelegate {
  
func close(error: Error?, completion: (() -> Void)?) { }
  
} // class MockCloseDelegate

final class OverlayViewModelTests: XCTestCase {
  
var closeDelegates = [CloseDelegate]()
var observers = [NSKeyValueObservation]()

func testInValidAdInfo() {
  let exp = defaultExpectation()
  let closeHelper = ErrorCloseHelper(expectation: exp)
  let sut = OverlayViewModel(adInfo: InValidAdInfo(), closeDelegate: closeHelper)
  sut.start()
  closeDelegates.append(closeHelper)
  wait(for: [exp], timeout: 2)
}
  
func testValidAdInfo() {
  let exp = defaultExpectation()
  let sut = OverlayViewModel(adInfo: ValidAdInfo(), closeDelegate: MockCloseDelegate())
  let observer = sut.observe(\OverlayViewModel.advertisingId, options: [.new, .initial]) { _, change in
    if let adId = change.newValue,
      !adId.isEmpty {
      exp.fulfill()
    }
  }
  observers.append(observer)
  sut.start()
  wait(for: [exp], timeout: 1)
}
  
func testTopTitle() {
  let exp = defaultExpectation()
  let sut = OverlayViewModel(adInfo: ValidAdInfo(), closeDelegate: MockCloseDelegate())
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
  let sut = OverlayViewModel(adInfo: ValidAdInfo(), closeDelegate: MockCloseDelegate())
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
  let sut = OverlayViewModel(adInfo: ValidAdInfo(), closeDelegate: MockCloseDelegate())
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
