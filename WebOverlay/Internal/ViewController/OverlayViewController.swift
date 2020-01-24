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
  
private let webView: WKWebView = {
  let view = WKWebView()
  return view
}()
  
override func viewDidLoad() {
  super.viewDidLoad()
  webView.load(URLRequest(url: URL(string: "https://www.google.com")!))
}
  
override func loadView() {
  let rootView = UIView()
  
  webView.translatesAutoresizingMaskIntoConstraints = false
  rootView.addSubview(webView)
  
  webView.leftAnchor.constraint(equalTo: rootView.leftAnchor).isActive = true
  webView.rightAnchor.constraint(equalTo: rootView.rightAnchor).isActive = true
  webView.topAnchor.constraint(equalTo: rootView.topAnchor).isActive = true
  webView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor).isActive = true
  
  view = rootView
}
  
}
