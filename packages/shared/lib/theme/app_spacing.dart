/// Quiet Tools 여백 체계 (8dp 그리드 기반)
abstract class AppSpacing {
  /// 인라인 소간격
  static const double s4 = 4.0;

  /// 컴포넌트 내부
  static const double s8 = 8.0;

  /// 카드 내부 패딩
  static const double s12 = 12.0;

  /// 화면 좌우 패딩 (기준 여백)
  static const double s16 = 16.0;

  /// 섹션 간 여백
  static const double s24 = 24.0;

  /// 콘텐츠 블록 간
  static const double s32 = 32.0;

  /// 히어로 패딩
  static const double s48 = 48.0;

  /// 최소 터치 영역 (WCAG AA)
  static const double minTouchTarget = 48.0;
}
