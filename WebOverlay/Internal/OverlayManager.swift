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
  
init(_ options: [StartOptions: String]) {
  self.options = options
}
 
func show() {
  guard let rootViewController = UIApplication.shared.windows.last?.rootViewController else { return }
  let parentController = topViewController(from: rootViewController)
  let viewController = OverlayViewController()
  let viewModel = OverlayViewModel()
  viewModel.options = options
  viewController.viewModel = viewModel
  parentController.present(viewController, animated: true, completion: nil)
  overlayViewController = viewController
}
  
private func postStartNotification() {
  NotificationCenter.default.post(name: Notification.Name.webOverlayDidStart, object: nil)
}
  
} // class OverlayManager
