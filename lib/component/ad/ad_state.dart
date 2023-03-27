import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  /// AdMobの広告ID
  static String get bannerAdUnitId => Platform.isAndroid
      ? ''
      : '';

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    onAdOpened: (Ad ad) => print('Ad opened.'),
    onAdClosed: (Ad ad) => print('Ad closed.'),
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );
}

String unitId(String adUnitId) {
  var isRelease = const bool.fromEnvironment('dart.vm.product');

  if (isRelease) {
    return adUnitId;
  } else {
    /// テスト用の広告ID
    return "ca-app-pub-3940256099942544/6300978111";
  }
}