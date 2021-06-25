//
//  WebViewPlugin.swift
//  Runner
//
//  Created by Achref Marzouki on 25/6/21.
//

import Flutter
import UIKit

public class FLWebViewPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = FLWebViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "FLWebView")
    }
}
