//
//  OverlayViewModel.swift
//  WebOverlay
//
//  Created by Khurram on 24/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class OverlayViewModel: NSObject {
  
var options = [StartOptions: String]()
@objc dynamic var option1 = ""
@objc dynamic var option2 = ""
@objc dynamic var urlString = ""
@objc dynamic var advertisingId = ""
  
private let adInfo: AdInfo
private weak var closeDelegate: CloseDelegate?
  
init(adInfo: AdInfo, closeDelegate: CloseDelegate) {
  self.adInfo = adInfo
  self.closeDelegate = closeDelegate
}
  
func start() {
  DispatchQueue.main.async {
    self.urlString = webUrlString
    self.option1 = self.options[.option1] ?? defaultOption1
    self.option2 = self.options[.option2] ?? defaultOption2
    if let adId = self.adInfo.advertisingIdentifier?.uuidString {
      self.advertisingId = adId
    }
  }
}
  
func close() {
  closeDelegate?.close()
}
  
} // class OverlayViewModel
