//
//  OverlayManager.swift
//  WebOverlay
//
//  Created by Khurram on 23/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import UIKit

final class OverlayManager {
  
private let options: [StartOptions: String]
private var overlayViewController: OverlayViewController?

var isOverlayVisible: Bool {
  overlayViewController?.isVisble ?? false
}
  
init(_ options: [StartOptions: String]) {
  self.options = options
}
 
func show(completion: (() -> Void)?) {
  let completion = {
    if let rootViewController = getRootViewController() {
      let presentingViewController = topViewController(from: rootViewController)
      let viewController = createOverlayViewController(options: self.options, closeDelegate: self)
      viewController.modalPresentationStyle = .fullScreen
      presentingViewController.view.window?.layer.add(getTransition(for: .show), forKey: kCATransition)
      presentingViewController.present(viewController, animated: false, completion: nil)
      self.overlayViewController = viewController
    }
    completion?()
    postShowNotification()
  }
  close(error: nil, completion: completion) // First close if there is already an overlay view controller
}
  
} // class OverlayManager

extension OverlayManager: CloseDelegate {

func close(error: Error?, completion: (() -> Void)?) {
  if let error = error {
    print(error)
  }
  if let viewController = overlayViewController {
    viewController.view.window?.layer.add(getTransition(for: .close), forKey: kCATransition)
    viewController.dismiss(animated: false, completion: completion)
  }
  overlayViewController = nil
  completion?()
  postCloseNotification(userInfo: userInfoForCloseNotification())
}
private func userInfoForCloseNotification() -> [AnyHashable: Any]{
  var userInfo = [AnyHashable: Any]()
  if let imageName = options[.closeButtonImageName] {
    userInfo[StartOptions.closeButtonImageName] = imageName
  }
  if let param4 = options[.option4] {
    userInfo[StartOptions.option4] = param4
  }
  if let param5 = options[.option5] {
    userInfo[StartOptions.option5] = param5
  }
  return userInfo
}
} // extension OverlayManager
