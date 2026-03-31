import 'package:flutter/material.dart';

/// Quiet Tools 타이포그래피 시스템
///
/// ⚠️ google_fonts 사용 금지 — NotoSansKR은 assets/fonts/에 번들됨
abstract class AppTypography {
  static const String _fontFamily = 'NotoSansKR';

  // ── TextTheme 빌더 ────────────────────────────────────────────

  /// 기본 TextTheme (NotoSansKR, 한국어 최적화)
  static TextTheme buildTextTheme() {
    return const TextTheme(
      displayLarge:  TextStyle(fontFamily: _fontFamily, fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: -0.25),
      displayMedium: TextStyle(fontFamily: _fontFamily, fontSize: 45, fontWeight: FontWeight.w400),
      displaySmall:  TextStyle(fontFamily: _fontFamily, fontSize: 36, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(fontFamily: _fontFamily, fontSize: 32, fontWeight: FontWeight.w700),
      headlineMedium:TextStyle(fontFamily: _fontFamily, fontSize: 28, fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(fontFamily: _fontFamily, fontSize: 24, fontWeight: FontWeight.w700),
      titleLarge:    TextStyle(fontFamily: _fontFamily, fontSize: 22, fontWeight: FontWeight.w500),
      titleMedium:   TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleSmall:    TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyLarge:     TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyMedium:    TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      bodySmall:     TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      labelLarge:    TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      labelMedium:   TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5),
      labelSmall:    TextStyle(fontFamily: _fontFamily, fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5),
    );
  }

  // ── 앱별 오버라이드 ───────────────────────────────────────────

  /// 튜너 앱 — 주파수 히어로 숫자 72sp Bold
  static TextStyle tunerHeroStyle() => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 72,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.0,
  );

  /// 일기/저널 앱 — bodyLarge 18sp, 행간 1.75
  static TextStyle journalBodyStyle() => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.75,
    letterSpacing: 0.5,
  );

  /// 응급처치 앱 — 단계 번호 40sp Bold
  static TextStyle firstAidStepStyle() => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w700,
  );

  // ── 유틸리티 ──────────────────────────────────────────────────

  /// Tabular figures 적용 (가계부 / 대출 계산기용)
  ///
  /// 숫자 정렬이 필요한 테이블, 금액 표시에 사용
  static TextStyle tabularFigures(TextStyle base) => base.copyWith(
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}
