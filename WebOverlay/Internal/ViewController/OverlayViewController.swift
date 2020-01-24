//
//  OverlayViewController.swift
//  WebOverlay
//
//  Created by Khurram on 24/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import WebKit
import UIKit

final class OverlayViewController: UIViewController {
var options = [StartOptions: String]()
private let webView: WKWebView = {
  let view = WKWebView()
  return view
}()
private let topLabel = UILabel()
private let bottomLabel = UILabel()
private let closeButton: UIButton = {
  let button = UIButton(type: .custom)
  button.setTitle("Close", for: .normal)
  return button
}()
  
override func viewDidLoad() {
  super.viewDidLoad()
  webView.load(URLRequest(url: URL(string: "https://www.pollfish.com")!))
  topLabel.text = options[.option1] ?? "defaultOption1"
  bottomLabel.text = options[.option2] ?? "defaultOption2"
}
  
override func loadView() {
  let rootView = UIView()
  
  for view in [webView, topLabel, bottomLabel, closeButton] {
    view.translatesAutoresizingMaskIntoConstraints = false
  }
  rootView.addSubview(webView)
  rootView.addSubview(topLabel)
  rootView.addSubview(bottomLabel)
  rootView.addSubview(closeButton)
  
  webView.leftAnchor.constraint(equalTo: rootView.leftAnchor).isActive = true
  webView.rightAnchor.constraint(equalTo: rootView.rightAnchor).isActive = true
  webView.topAnchor.constraint(equalTo: rootView.topAnchor).isActive = true
  webView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor).isActive = true
  
  topLabel.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
  topLabel.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 20).isActive = true
  
  bottomLabel.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
  bottomLabel.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -20).isActive = true
  
  closeButton.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 20).isActive = true
  closeButton.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 20).isActive = true
  
  view = rootView
}
  
}
