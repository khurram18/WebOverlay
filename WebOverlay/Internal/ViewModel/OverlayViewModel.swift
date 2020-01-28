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
@objc dynamic var topTitle = ""
@objc dynamic var bottomTitle = ""
@objc dynamic var closeImageName = ""
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
    self.topTitle = self.options[.topTitle] ?? defaultTopTitle
    self.bottomTitle = self.options[.bottomTitle] ?? defaultBottomTitle
    if let imageName = self.options[.closeButtonImageName] {
      self.closeImageName = imageName
    }
    if let adId = self.adInfo.advertisingIdentifier?.uuidString {
      self.advertisingId = adId
    }
  }
}
  
func close() {
  closeDelegate?.close()
}
  
} // class OverlayViewModel
