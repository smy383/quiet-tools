import 'package:flutter/material.dart';

/// 앱별 Material 3 Seed Color
abstract class AppSeeds {
  /// 습관 추적기 — Teal
  static const Color habitTracker = Color(0xFF26A69A);

  /// 가계부 — Indigo (Tabular figures 사용)
  static const Color expenseTracker = Color(0xFF3949AB);

  /// 일기/저널 — Mauve (bodyLarge 18sp)
  static const Color journal = Color(0xFFAD7FA8);

  /// 운동 기록기 — Deep Orange (달성 애니메이션 강조)
  static const Color workoutLogger = Color(0xFFF4511E);

  /// 단위 변환기 — Slate Blue
  static const Color unitConverter = Color(0xFF5C6BC0);

  /// 대출 계산기 — Dark Teal (Tabular figures 사용)
  static const Color loanCalculator = Color(0xFF00695C);

  /// 백색소음 — Midnight Indigo (기본값: 다크모드)
  static const Color sleepSound = Color(0xFF283593);

  /// 응급처치 — Safety Red (인터스티셜 없음, 기본값: 라이트모드)
  static const Color firstAid = Color(0xFFC62828);

  /// 튜너 — Warm Amber (displayLarge 72sp 주파수 표시)
  static const Color tuner = Color(0xFFF57F17);

  /// 독서 기록 — Warm Brown
  static const Color bookTracker = Color(0xFF6D4C41);
}
