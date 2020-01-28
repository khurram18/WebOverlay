//
//  notifications.swift
//  WebOverlay
//
//  Created by Khurram on 27/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

func postShowNotification() {
  NotificationCenter.default.post(name: Notification.Name.webOverlayDidShow, object: nil)
}

func postCloseNotification(userInfo: [AnyHashable: Any]? = nil) {
  NotificationCenter.default.post(name: Notification.Name.webOverlayDidClose, object: nil, userInfo: userInfo)
}
