//
//  WebView.swift
//  Runner
//
//  Created by Achref Marzouki on 25/6/21.
//

import WebKit
import Flutter
import UIKit

class FLWebViewFactory: NSObject, FlutterPlatformViewFactory {
    
    // MARK: - Private
    
    private var messenger: FlutterBinaryMessenger
    
    // MARK: - Initializers
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    // MARK: - UI
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FLWebView(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
    }
}

class FLWebView: NSObject, FlutterPlatformView {
    
    // MARK: - Private
    
    private var _view: UIView
    private weak var loader: UIActivityIndicatorView!
    
    // MARK: - Initializers
    
    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: FlutterBinaryMessenger?) {
        _view = UIView()
        super.init()
        createNativeView(frame: frame)
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createNativeView(frame: CGRect) {
        // web view
        let webView = WKWebView()
        webView.navigationDelegate = self
        let url = URL(string: "https://preview.colorlib.com/theme/bootstrap/contact-form-02")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        _view = webView
        // loader
        let activityIndicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .large)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .gray)
        }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        _view.addSubview(activityIndicator)
        loader = activityIndicator
        loader.centerXAnchor.constraint(equalTo: _view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: _view.centerYAnchor).isActive = true
        loader.startAnimating()
    }
}

extension FLWebView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loader.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loader.stopAnimating()
    }
}
