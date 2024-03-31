import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var fyberChannel: FlutterMethodChannel?
    var viewModel: FyberAdViewModel?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
      
      fyberChannel = FlutterMethodChannel(name: "com.example.fyber_service",
                                                  binaryMessenger: flutterViewController.binaryMessenger)
      viewModel = FyberAdViewModel(fyberChannel: fyberChannel!)
      
      fyberChannel?.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          switch call.method{
          case "init":
              guard let args = call.arguments as? [String : Any],
                    let appId = args["appId"] as? String else {
                  result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
                  return
              }
              self?.initFairBid(appId)
              result(nil)
              break
          case "requestAd":
              guard let args = call.arguments as? [String : Any],
                    let placementId = args["placementId"] as? String else {
                  result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
                  return
              }
              self?.requestAd(placementId)
              result(nil)
              break
          default:
              result(FlutterMethodNotImplemented)
          }
      })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func initFairBid(_ appId: String) {
        viewModel?.initFairBid(appId)
    }
    
    
    private func requestAd(_ placementId: String) {
        viewModel?.request(placementId)
    }
}
