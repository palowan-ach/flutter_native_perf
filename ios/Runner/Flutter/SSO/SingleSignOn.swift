//
//  SingleSignOn.swift
//  Runner
//
//  Created by Achref Marzouki on 25/6/21.
//

import Flutter
import UIKit
import GoogleSignIn

class FLSingleSignOnViewFactory: NSObject, FlutterPlatformViewFactory {
    
    // MARK: - Private
    
    private var messenger: FlutterBinaryMessenger
    
    // MARK: - Initializers
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    // MARK: - UI
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FLSingleSignOnView(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
    }
}

class FLSingleSignOnView: NSObject, FlutterPlatformView {
    
    // MARK: - Private
    
    private var _view: UIView
    private weak var loader: UIActivityIndicatorView!
    
    // MARK: - Initializers
    
    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: FlutterBinaryMessenger?) {
        _view = UIView()
        super.init()
        GIDSignIn.sharedInstance().presentingViewController = Utilities.currentViewController()
        createNativeView(frame: frame)
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createNativeView(frame: CGRect) {
        let signinButton = GIDSignInButton()
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        _view.addSubview(signinButton)
        signinButton.centerXAnchor.constraint(equalTo: _view.centerXAnchor).isActive = true
        signinButton.centerYAnchor.constraint(equalTo: _view.centerYAnchor).isActive = true
//        // loader
//        let activityIndicator: UIActivityIndicatorView
//        if #available(iOS 13.0, *) {
//            activityIndicator = UIActivityIndicatorView(style: .large)
//        } else {
//            activityIndicator = UIActivityIndicatorView(style: .gray)
//        }
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        _view.addSubview(activityIndicator)
//        loader = activityIndicator
//        loader.centerXAnchor.constraint(equalTo: _view.centerXAnchor).isActive = true
//        loader.centerYAnchor.constraint(equalTo: _view.centerYAnchor).isActive = true
//        loader.startAnimating()
    }
}
