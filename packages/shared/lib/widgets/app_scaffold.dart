import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../theme/app_colors.dart';

/// AdMob 배너 위치
enum AdBannerPosition { top, bottom }

/// Quiet Tools 공통 Scaffold
///
/// 모든 앱에서 동일한 AdMob 배너 처리를 위해 사용한다.
///
/// 배너 규격: 320×50 Standard Banner
/// 배너 배경: surfaceContainerLow
/// 구분선:   outlineVariant 1dp
///
/// 예외 적용:
/// - 백색소음, 튜너: [adBannerPosition] = [AdBannerPosition.top]
/// - 응급처치: 인터스티셜 없음 (AppScaffold와 무관, 앱에서 처리)
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.adBannerPosition = AdBannerPosition.bottom,
    this.showAd = true,
    this.adUnitId,
    this.resizeToAvoidBottomInset = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final AdBannerPosition adBannerPosition;

  /// false로 설정하면 광고 배너를 숨긴다 (개발/테스트 용)
  final bool showAd;

  /// AdMob 광고 단위 ID. null이면 테스트 ID를 자동 사용한다.
  final String? adUnitId;

  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final adBanner = showAd ? _AdBannerWidget(adUnitId: adUnitId) : null;

    // 광고 배너를 body 상단에 표시할 때만 Column으로 처리
    Widget effectiveBody = body;
    if (adBanner != null && adBannerPosition == AdBannerPosition.top) {
      effectiveBody = Column(
        children: [
          adBanner,
          Expanded(child: body),
        ],
      );
    }

    // 하단 광고는 bottomNavigationBar에 배치 → 시스템 네비게이션바 inset 자동 처리
    Widget? effectiveBottomBar = bottomNavigationBar;
    if (adBanner != null && adBannerPosition == AdBannerPosition.bottom) {
      effectiveBottomBar = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (bottomNavigationBar != null) bottomNavigationBar!,
          adBanner,
        ],
      );
    }

    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: effectiveBottomBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: effectiveBody,
    );
  }
}

// ── 내부 AdBanner 위젯 ────────────────────────────────────────────

class _AdBannerWidget extends StatefulWidget {
  const _AdBannerWidget({this.adUnitId});

  final String? adUnitId;

  @override
  State<_AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<_AdBannerWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  /// Android 테스트 배너 ID
  static const _testAdUnitIdAndroid = 'ca-app-pub-3940256099942544/6300978111';

  /// iOS 테스트 배너 ID
  static const _testAdUnitIdIos = 'ca-app-pub-3940256099942544/2934735716';

  String get _effectiveAdUnitId {
    if (widget.adUnitId != null) return widget.adUnitId!;
    // 플랫폼별 테스트 ID 자동 선택
    return Theme.of(context).platform == TargetPlatform.iOS
        ? _testAdUnitIdIos
        : _testAdUnitIdAndroid;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: _effectiveAdUnitId,
      size: AdSize.banner, // 320×50
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (mounted) setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _bannerAd = null;
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox(height: 50);
    }

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bannerBg = isDark ? AppColors.adBannerDark : AppColors.adBannerLight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1,
          thickness: 1,
          color: colorScheme.outlineVariant,
        ),
        Container(
          height: 50,
          color: bannerBg,
          child: SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          ),
        ),
      ],
    );
  }
}
