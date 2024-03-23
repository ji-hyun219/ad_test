import UIKit
import Flutter
import FairBidSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
    let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
          
    let fyberChannel = FlutterMethodChannel(name: "com.example.fyber_service",
                                                  binaryMessenger: flutterViewController.binaryMessenger)
    fyberChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard call.method == "init" else {
                result(FlutterMethodNotImplemented)
                return
            }
            print("fyber init test")
        })
          
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
