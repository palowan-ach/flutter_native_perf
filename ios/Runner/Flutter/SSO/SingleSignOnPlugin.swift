//
//  SingleSignOnPlugin.swift
//  Runner
//
//  Created by Achref Marzouki on 25/6/21.
//

import Flutter
import UIKit

public class FLSingleSignOnViewPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = FLSingleSignOnViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "FLSingleSignOnView")
    }
}
