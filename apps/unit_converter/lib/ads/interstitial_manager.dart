import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialManager {
  static const _threshold = 5;

  static String get _adUnitId {
    if (kDebugMode) {
      // 테스트 광고 ID
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    }
    // TODO: 실제 광고 ID로 교체
    return Platform.isAndroid
        ? 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'
        : 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';
  }

  InterstitialAd? _ad;
  bool _isLoading = false;

  Future<void> load() async {
    if (_isLoading || _ad != null) return;
    _isLoading = true;

    await InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _isLoading = false;
          _ad!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _ad = null;
              load(); // 다음 광고 미리 로드
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _ad = null;
              load();
            },
          );
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          debugPrint('InterstitialAd load failed: $error');
        },
      ),
    );
  }

  void tryShow(int conversionCount) {
    if (conversionCount > 0 && conversionCount % _threshold == 0) {
      if (_ad != null) {
        _ad!.show();
      }
    }
  }

  void dispose() {
    _ad?.dispose();
    _ad = null;
  }
}

final interstitialManagerProvider = Provider<InterstitialManager>((ref) {
  final manager = InterstitialManager();
  manager.load();
  ref.onDispose(manager.dispose);
  return manager;
});
