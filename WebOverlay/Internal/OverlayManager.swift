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
  close() // First close if there is already an overlay view controller
  guard let window = UIApplication.shared.windows.last,
    let rootViewController = window.rootViewController else { return }
  let presentingViewController = topViewController(from: rootViewController)
  let viewController = createOverlayViewController(options: options, closeDelegate: self)
  viewController.modalPresentationStyle = .fullScreen
  presentingViewController.view.window?.layer.add(getTransition(for: .show), forKey: kCATransition)
  presentingViewController.present(viewController, animated: false, completion: nil)
  overlayViewController = viewController
}
  
} // class OverlayManager

extension OverlayManager: CloseDelegate {

func close() {
  guard let viewController = overlayViewController else { return }
  viewController.view.window?.layer.add(getTransition(for: .close), forKey: kCATransition)
  viewController.dismiss(animated: false, completion: nil)
  overlayViewController = nil
}
  
} // extension OverlayManager
