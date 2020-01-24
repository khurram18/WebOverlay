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
  
@objc dynamic var viewModel: OverlayViewModel?
  
private let webView = WKWebView()
private let topLabel = UILabel()
private let bottomLabel = UILabel()
private let closeButton = UIButton(type: .custom)

private var urlObservation: NSKeyValueObservation?
private var option1Observation: NSKeyValueObservation?
private var option2Observation: NSKeyValueObservation?
private var closeTitleObservation: NSKeyValueObservation?

override func viewWillAppear(_ animated: Bool) {
  super.viewWillAppear(animated)
  observeViewModel()
}
  
override func viewWillDisappear(_ animated: Bool) {
  super.viewWillDisappear(animated)
  removeViewModelObservers()
}
  
override func viewDidAppear(_ animated: Bool) {
  super.viewDidAppear(animated)
  viewModel?.start()
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
  
private func observeViewModel() {
  
  guard let viewModel = viewModel else { return }
  
  urlObservation = viewModel.observe(\OverlayViewModel.urlString, options: [.new, .initial]) { _, change in
    guard let newValue = change.newValue, let url = URL(string: newValue) else { return }
    self.webView.load(URLRequest(url: url))
  }
  option1Observation = viewModel.observe(\OverlayViewModel.option1, options: [.new, .initial]) { _, change in
    self.topLabel.text = change.newValue
  }
  option2Observation = viewModel.observe(\OverlayViewModel.option2, options: [.new, .initial]) { _, change in
    self.bottomLabel.text = change.newValue
  }
  closeTitleObservation = viewModel.observe(\OverlayViewModel.closeTitle, options: [.new, .initial]) { _, change in
    guard let title = change.newValue else { return }
    self.closeButton.setTitle(title, for: .normal)
  }
}
  
private func removeViewModelObservers() {
  urlObservation = nil
  option1Observation = nil
  option2Observation = nil
  closeTitleObservation = nil
}
  
} // class OverlayViewController
