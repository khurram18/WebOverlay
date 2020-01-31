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
private let closeButton = UIButton(type: .custom)

private var urlObservation: NSKeyValueObservation?
private var topTitleObservation: NSKeyValueObservation?
private var bottomTitleObservation: NSKeyValueObservation?
private var closeImageNameObservation: NSKeyValueObservation?
private var adIdObservation: NSKeyValueObservation?

override func viewWillAppear(_ animated: Bool) {
  super.viewWillAppear(animated)
  observeViewModel()
  closeButton.addTarget(self, action: #selector(onCloseTap), for: .touchUpInside)
  webView.navigationDelegate = self
}
  
override func viewWillDisappear(_ animated: Bool) {
  super.viewWillDisappear(animated)
  removeViewModelObservers()
  webView.navigationDelegate = nil
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
  closeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
  closeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
  
  view = rootView
}
  
private func observeViewModel() {
  
  guard let viewModel = viewModel else { return }
  
  urlObservation = viewModel.observe(\OverlayViewModel.urlString, options: [.new, .initial]) { _, change in
    guard let newValue = change.newValue, let url = URL(string: newValue) else { return }
    self.webView.load(URLRequest(url: url))
  }
  topTitleObservation = viewModel.observe(\OverlayViewModel.topTitle, options: [.new, .initial]) { _, change in
    self.topLabel.text = change.newValue
  }
  bottomTitleObservation = viewModel.observe(\OverlayViewModel.bottomTitle, options: [.new, .initial]) { _, change in
    self.bottomLabel.text = change.newValue
  }
  adIdObservation = viewModel.observe(\OverlayViewModel.advertisingId, options: [.new, .initial]) { _, change in
    self.adLabel.text = change.newValue
  }
  closeImageNameObservation = viewModel.observe(\OverlayViewModel.closeImageName, options: [.new, .initial]) { _, change in
    if let imageName = change.newValue {
      self.closeButton.setImage(UIImage(named: imageName), for: .normal)
    }
  }
}
  
private func removeViewModelObservers() {
  urlObservation = nil
  topTitleObservation = nil
  bottomTitleObservation = nil
  adIdObservation = nil
  closeImageNameObservation = nil
}
  
@objc private func onCloseTap() {
  viewModel?.close(error: nil)
}
  
} // class OverlayViewController

extension OverlayViewController: WKNavigationDelegate {
func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
  viewModel?.close(error: error)
}
} // extension OverlayViewController
