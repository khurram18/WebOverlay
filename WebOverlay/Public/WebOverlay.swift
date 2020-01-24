//
//  WebOverlay.swift
//  WebOverlay
//
//  Created by Khurram on 23/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation


public final class WebOverlay {
  
private var manager: OverlayManager?
  
public static let sharedInstance = WebOverlay()
  
public func start(with options: [StartOptions: String]) {
  manager = OverlayManager(options)
}

public func show() {
  manager?.show()
}


private init(){}
  
} // class WebOverlay
