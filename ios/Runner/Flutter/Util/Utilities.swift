//
//  Utilities.swift
//  Runner
//
//  Created by Achref Marzouki on 25/6/21.
//

import Foundation

public class Utilities {
    static func currentViewController() -> UIViewController? {
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
        } else {
            window = UIApplication.shared.keyWindow
        }
        if var topController = window?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        
        return nil
    }
}
