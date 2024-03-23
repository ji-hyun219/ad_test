import 'package:flutter/services.dart';

class MethodChannelService {
  static const MethodChannel _channel = MethodChannel('com.example.fyber_service');

  Future<void> initFyberAd(String appId) async {
    await _channel.invokeMethod('init', {'appId' : appId});
  }
}