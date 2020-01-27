//
//  OverlayManager+Transition.swift
//  WebOverlay
//
//  Created by Khurram on 27/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

enum Action {
case show
case close
}

private let transitionDuration: CFTimeInterval = 0.25

func getTransition(for action: Action) -> CATransition {
  let transition = CATransition()
  transition.duration = transitionDuration
  switch action {
  case .show:
    transition.type = .push
    transition.subtype = .fromRight
  case .close:
    transition.type = .reveal
    transition.subtype = .fromLeft
  }
  
  return transition
}
