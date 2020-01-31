//
//  ViewController.swift
//  App
//
//  Created by Khurram on 31/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import WebOverlay
import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  @IBAction func onOverlayTap(_ sender: Any) {
    WebOverlay.sharedInstance.show()
  }
  

}

