//
//  topViewController.swift
//  WebOverlay
//
//  Created by Khurram on 24/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import UIKit

func topViewController(from viewController: UIViewController) -> UIViewController {
  if let navigationController = viewController as? UINavigationController,
    let visibleViewController = navigationController.visibleViewController {
    return topViewController(from: visibleViewController)
  }
  else if let tabBarController = viewController as? UITabBarController,
    let selectedViewController = tabBarController.selectedViewController {
    return topViewController(from: selectedViewController)
  }
  else if let presentedViewController = viewController.presentedViewController {
    return topViewController(from: presentedViewController)
  }
  return viewController
}