import 'ad.dart';

class AdListener {
  final void Function(Ad ad) onAdLoadedCallback;
  final void Function(String adUnitId, AdError error) onAdLoadFailedCallback;
  final void Function(Ad ad)? onAdRevenuePaidCallback;
  final void Function(Ad ad) onAdDisplayedCallback;
  final void Function(Ad ad, AdError error) onAdDisplayFailedCallback;

  const AdListener({
    required this.onAdLoadedCallback,
    required this.onAdLoadFailedCallback,
    this.onAdRevenuePaidCallback,
    required this.onAdDisplayedCallback,
    required this.onAdDisplayFailedCallback,
  });
}
