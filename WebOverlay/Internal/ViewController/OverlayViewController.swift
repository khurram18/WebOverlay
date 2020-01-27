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
private let adLabel = UILabel()
private let closeButton: UIButton = {
  let button = UIButton(type: .custom)
  button.backgroundColor = .black
  button.titleLabel?.textColor = .white
  return button
}()

private var urlObservation: NSKeyValueObservation?
private var option1Observation: NSKeyValueObservation?
private var option2Observation: NSKeyValueObservation?
private var closeTitleObservation: NSKeyValueObservation?
private var adIdObservation: NSKeyValueObservation?

override func viewWillAppear(_ animated: Bool) {
  super.viewWillAppear(animated)
  observeViewModel()
  closeButton.addTarget(self, action: #selector(onCloseTap), for: .touchUpInside)
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
  if #available(iOS 13.0, *) {
    rootView.backgroundColor = .systemBackground
  } else {
    rootView.backgroundColor = .white
  }
  
  for view in [webView, topLabel, bottomLabel, adLabel, closeButton] {
    view.translatesAutoresizingMaskIntoConstraints = false
  }
  rootView.addSubview(webView)
  rootView.addSubview(topLabel)
  rootView.addSubview(bottomLabel)
  rootView.addSubview(adLabel)
  rootView.addSubview(closeButton)
  
  webView.leftAnchor.constraint(equalTo: rootView.leftAnchor).isActive = true
  webView.rightAnchor.constraint(equalTo: rootView.rightAnchor).isActive = true
  let topAnchor: NSLayoutYAxisAnchor
  let bottomAnchor: NSLayoutYAxisAnchor
  if #available(iOS 11.0, *) {
    topAnchor = rootView.safeAreaLayoutGuide.topAnchor
    bottomAnchor = rootView.safeAreaLayoutGuide.bottomAnchor
  } else {
    topAnchor = rootView.topAnchor
    bottomAnchor = rootView.bottomAnchor
  }
  webView.topAnchor.constraint(equalTo: topAnchor).isActive = true
  webView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  
  topLabel.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
  topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
  
  bottomLabel.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
  bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
  
  adLabel.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
  adLabel.centerYAnchor.constraint(equalTo: rootView.centerYAnchor).isActive = true
  
  closeButton.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 20).isActive = true
  closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
  
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
  adIdObservation = viewModel.observe(\OverlayViewModel.advertisingId, options: [.new, .initial]) { _, change in
    self.adLabel.text = change.newValue
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
  adIdObservation = nil
}
  
@objc private func onCloseTap() {
  viewModel?.close()
}
  
} // class OverlayViewController
