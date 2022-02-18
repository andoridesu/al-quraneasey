import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Adshelper {
  static const idads = 'ca-app-pub-3940256099942544/6300978111'; // tester
  static const idinert = 'ca-app-pub-3940256099942544/1033173712'; // tester

  static init() {
    MobileAds.instance.initialize();
  }

  static adBaner() {
    BannerAd(
        size: AdSize.banner,
        adUnitId: Adshelper.idads,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            debugPrint('$BannerAd loaded.');
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            debugPrint('$BannerAd failedToLoad: $error');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => debugPrint('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => debugPrint('$BannerAd onAdClosed.'),
        ),
        request: const AdRequest());
  }

  static adInertitial() {
    return InterstitialAd.load(
        adUnitId: idinert,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {},
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  static handlerBner(ad) {
    BannerAdListener(
      onAdLoaded: (Ad ad) {
        debugPrint('$BannerAd loaded.');
      },
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        debugPrint('$BannerAd failedToLoad: $error');
        ad.dispose();
      },
      onAdOpened: (Ad ad) => debugPrint('$BannerAd onAdOpened.'),
      onAdClosed: (Ad ad) => debugPrint('$BannerAd onAdClosed.'),
    );
  }
}
