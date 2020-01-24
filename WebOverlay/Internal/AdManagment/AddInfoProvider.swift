//
//  AddInfoProvider.swift
//  WebOverlay
//
//  Created by Khurram on 25/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import AdSupport
import Foundation

final class AdInfoProvider: AdInfo {
  
var advertisingIdentifier: UUID?
  
init() {
  advertisingIdentifier = ASIdentifierManager.shared().isAdvertisingTrackingEnabled ? ASIdentifierManager.shared().advertisingIdentifier : nil
}
  
} // class AdInfoProvider
