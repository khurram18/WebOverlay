//
//  WebOverlay.swift
//  WebOverlay
//
//  Created by Khurram on 23/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import Foundation

public final class WebOverlay {
  
private var manager: OverlayManager?
private var options = [StartOptions: String]()
public static let sharedInstance = WebOverlay()
  
public func start(with options: [StartOptions: String]) {
  self.options = options
  createManager()
}

public func show() {
  manager?.show(completion: nil)
}

private init() {
  listenOrientationChangeNotifications()
}
  
private func createManager() {
  let visible = self.manager?.isOverlayVisible ?? false
  let completion = {
    self.manager = OverlayManager(self.options)
    if visible {
      self.manager?.show(completion: nil)
    }
  }
  if visible {
    self.manager?.close(error: nil, completion: completion)
  } else {
    completion()
  }
}
  
} // class WebOverlay

extension WebOverlay {
private func listenOrientationChangeNotifications() {
  UIDevice.current.beginGeneratingDeviceOrientationNotifications()
  NotificationCenter.default.addObserver(self, selector: #selector(onOrientationChange(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
}
@objc private func onOrientationChange(_ notification: Notification) {
  DispatchQueue.main.async {
    self.createManager()
  }
}
} // extension WebOverlay
