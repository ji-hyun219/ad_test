import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/ad.dart';
import '../model/ad_listener.dart';

class AdService {
  static const MethodChannel channel = MethodChannel('com.example.fyber_service');

  static AdListener? _adListener;

  AdService();

  static Future<void> initialize(String appKey) async {
    channel.setMethodCallHandler((MethodCall call) async {
      final method = call.method;
      final Map<dynamic, dynamic>? arguments = jsonDecode(call.arguments);

      switch (method) {
        case "adLoaded":
          _adListener?.onAdLoadedCallback.call(Ad(arguments!["placementId"] ?? ""));
          break;
        case "adLoadedFailed":
          _adListener?.onAdLoadFailedCallback(
              arguments!["placementId"] ?? "", AdError(arguments["errorMessage"] ?? ""));
          break;
        case "adShown":
          _adListener?.onAdDisplayedCallback.call(Ad(arguments!["placementId"] ?? ""));
          break;
        case "adShwonFailed":
          _adListener?.onAdDisplayFailedCallback(
              Ad(arguments!["placementId"] ?? ""), AdError(arguments["errorMessage"] ?? ""));
          break;
        default:
          throw MissingPluginException("Method not implemented, $method");
      }
    });

    initFyberAd(appKey);
  }

  static void setAdListener(AdListener listener) {
    _adListener = listener;
  }

  static Future<void> initFyberAd(String appId) async {
    await channel.invokeMethod('init', {'appId': appId});
  }

  static Future<void> setFyberAdUserId(String userId) async {
    await channel.invokeMethod('setUserId', {'userId': userId});
  }

  static Future<void> requestAd(String placementId) async {
    await channel.invokeMethod('requestAd', {'placementId': placementId});
  }

  static Future<void> showAd(String placementId) async {
    await channel.invokeMethod('showAd', {'placementId': placementId});
  }
}
