//
//  OverlayManagerTests.swift
//  WebOverlayTests
//
//  Created by Khurram on 31/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//
@testable import WebOverlay
import XCTest

final class OverlayManagerTests: XCTestCase {

func testShowOverlay() {
  let sut = OverlayManager(testStartOptions)
  let showNotificationExpectation = expectation(forNotification: .webOverlayDidShow, object: nil, handler: nil)
  sut.show(completion: nil)
  wait(for: [showNotificationExpectation], timeout: 2)
}
  
func testCloseOverlay() {
  let sut = OverlayManager(testStartOptions)
  let showNotificationExpectation = expectation(forNotification: .webOverlayDidClose, object: nil, handler: nil)
  sut.show() {
    sut.close(completion: nil)
  }
  wait(for: [showNotificationExpectation], timeout: 2)
}
  
} // class OverlayManagerTests
