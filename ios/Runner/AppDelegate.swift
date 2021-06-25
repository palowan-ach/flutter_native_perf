import UIKit
import Flutter
import GoogleSignIn

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // flutter plugings
        FLWebViewPlugin.register(with: registrar(forPlugin: "WebView")!)
        FLSingleSignOnViewPlugin.register(with: registrar(forPlugin: "SignleSignOn")!)
        
        // google sign in
        GIDSignIn.sharedInstance().clientID = "486652889849-gomvtcdafilgocqnadn9d907krp8nqt8.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    @available(iOS 9.0, *)
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}

extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}
