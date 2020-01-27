//
//  notifications.swift
//  WebOverlay
//
//  Created by Khurram on 27/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

func postStartNotification() {
  NotificationCenter.default.post(name: Notification.Name.webOverlayDidStart, object: nil)
}
