import 'package:firebase_admob/firebase_admob.dart';

class AdMobService {
  String getAdMobAppId() {
    return 'ca-app-pub-8970826678290556~6360014396';
  }

  String getBannerAdId() {
    return 'ca-app-pub-8970826678290556/5919362391';
  }

  String getInterstitialId() {
    return 'ca-app-pub-8970826678290556/8621563260';
  }

  InterstitialAd getNewInterstitial() {
    return InterstitialAd(
      adUnitId: getInterstitialId(),
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }
}
