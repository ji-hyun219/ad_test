//
//  FyberViewModel.swift
//  Runner
//
//  Created by 이지현 on 3/31/24.
//

import Foundation
import FairBidSDK

class FyberAdViewModel: NSObject {
    let fyberChannel: FlutterMethodChannel
    
    init(fyberChannel: FlutterMethodChannel) {
        self.fyberChannel = fyberChannel
        super.init()
        
        FYBRewarded.delegate = self
    }
    
    func initFairBid(_ appId: String) {
        let options = FYBStartOptions()
        options.autoRequestingEnabled = false
        options.logLevel = .verbose
                
        FairBid.start(withAppId: appId, options: options)
    }
    
    func request(_ placementId: String) {
        FYBRewarded.request(placementId)
    }
}

extension FyberAdViewModel: FYBRewardedDelegate {
    func rewardedIsAvailable(_ placementName: String) {
        print("FyberAd rewardedIsAvailable ")
        
        let jsonData: [String:Any] = [
            "placementId" : placementName,
        ] as Dictionary
        
        var jsonString = ""
        do {
            let json = try JSONSerialization.data(withJSONObject: jsonData)
            jsonString = String(data: json, encoding: String.Encoding.utf8) ?? ""
        } catch {
            print("JSON parsing Error")
        }
        
        fyberChannel.invokeMethod("adLoaded", arguments: jsonString)
    }
    
    func rewardedIsUnavailable(_ placementName: String) {
        print("FyberAd rewardedIsUnavailable ")
        
        let jsonData: [String:Any] = [
            "placementId" : placementName,
            "errorMessage" : "rewardedIsUnavailable"
        ] as Dictionary
        
        var jsonString = ""
        do {
            let json = try JSONSerialization.data(withJSONObject: jsonData)
            jsonString = String(data: json, encoding: String.Encoding.utf8) ?? ""
        } catch {
            print("JSON parsing Error")
        }
        
        fyberChannel.invokeMethod("adFailed", arguments: jsonString)
    }
    
    func rewardedDidShow(_ placementName: String, impressionData: FYBImpressionData) {
        print("FyberAd rewardedDidShow ")
    }
    
    func rewardedDidFail(toShow placementName: String, withError error: Error, impressionData: FYBImpressionData) {
        print("FyberAd rewardedDidFail ")
        
        let jsonData: [String:Any] = [
            "placementId" : placementName,
            "errorMessage" : error.localizedDescription + impressionData.description
        ] as Dictionary
        
        var jsonString = ""
        do {
            let json = try JSONSerialization.data(withJSONObject: jsonData)
            jsonString = String(data: json, encoding: String.Encoding.utf8) ?? ""
        } catch {
            print("JSON parsing Error")
        }
        
        fyberChannel.invokeMethod("adFailed", arguments: jsonString)
    }
    
    func rewardedDidClick(_ placementName: String) {
        print("FyberAd rewardedDidClick ")
    }
    
    func rewardedDidComplete(_ placementName: String, userRewarded: Bool) {
        print("FyberAd rewardedDidComplete ")
        
        let jsonData: [String:Any] = [
            "placementId" : placementName,
            "userRewarded" : userRewarded
        ] as Dictionary
        
        var jsonString = ""
        do {
            let json = try JSONSerialization.data(withJSONObject: jsonData)
            jsonString = String(data: json, encoding: String.Encoding.utf8) ?? ""
        } catch {
            print("JSON parsing Error")
        }
        
        fyberChannel.invokeMethod("adCompleted", arguments: jsonString)
    }
    
    func rewardedDidDismiss(_ placementName: String) {
        print("FyberAd rewardedDidDismiss ")
    }
  
    func rewardedWillRequest(_ placementId: String, withRequestId requestId: String) {
        print("FyberAd rewardedWillRequest ")
    }
}

