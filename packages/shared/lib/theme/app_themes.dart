import 'package:flutter/material.dart';

import 'app_seeds.dart';
import 'app_theme_base.dart';

/// 앱별 ThemeData 인스턴스
///
/// 각 앱은 이 클래스의 정적 메서드를 통해 테마를 가져온다.
/// 예시: MaterialApp(theme: AppThemes.habitTrackerLight(), ...)
abstract class AppThemes {
  // ── 1. 습관 추적기 ─────────────────────────────────────────
  static ThemeData habitTrackerLight() =>
      AppThemeBase.light(seedColor: AppSeeds.habitTracker);
  static ThemeData habitTrackerDark({bool amoled = false}) =>
      AppThemeBase.dark(seedColor: AppSeeds.habitTracker, amoled: amoled);

  // ── 2. 가계부 ──────────────────────────────────────────────
  static ThemeData expenseTrackerLight() =>
      AppThemeBase.light(seedColor: AppSeeds.expenseTracker);
  static ThemeData expenseTrackerDark({bool amoled = false}) =>
      AppThemeBase.dark(seedColor: AppSeeds.expenseTracker, amoled: amoled);

  // ── 3. 일기/저널 ───────────────────────────────────────────
  static ThemeData journalLight() =>
      AppThemeBase.light(seedColor: AppSeeds.journal);
  static ThemeData journalDark({bool amoled = false}) =>
      AppThemeBase.dark(seedColor: AppSeeds.journal, amoled: amoled);

  // ── 4. 운동 기록기 ─────────────────────────────────────────
  static ThemeData workoutLoggerLight() =>
      AppThemeBase.light(seedColor: AppSeeds.workoutLogger);
  static ThemeData workoutLoggerDark({bool amoled = false}) =>
      AppThemeBase.dark(seedColor: AppSeeds.workoutLogger, amoled: amoled);

  // ── 5. 단위 변환기 ─────────────────────────────────────────
  static ThemeData unitConverterLight() =>
      AppThemeBase.light(seedColor: AppSeeds.unitConverter);
  static ThemeData unitConverterDark({bool amoled = false}) =>
      AppThemeBase.dark(seedColor: AppSeeds.unitConverter, amoled: amoled);

  // ── 6. 대출 계산기 ─────────────────────────────────────────
  static ThemeData loanCalculatorLight() =>
      AppThemeBase.light(seedColor: AppSeeds.loanCalculator);
  static ThemeData loanCalculatorDark({bool amoled = false}) =>
      AppThemeBase.dark(seedColor: AppSeeds.loanCalculator, amoled: amoled);

  // ── 7. 백색소음 (기본값: 다크모드) ────────────────────────
  static ThemeData sleepSoundLight() =>
      AppThemeBase.light(seedColor: AppSeeds.sleepSound);
  static ThemeData sleepSoundDark({bool amoled = false}) =>
      AppThemeBase.dark(seedColor: AppSeeds.sleepSound, amoled: amoled);

  // ── 8. 응급처치 (기본값: 라이트모드, 인터스티셜 없음) ─────
  static ThemeData firstAidLight() =>
      AppThemeBase.light(seedColor: AppSeeds.firstAid);
  static ThemeData firstAidDark({bool amoled = false}) =>
      AppThemeBase.dark(seedColor: AppSeeds.firstAid, amoled: amoled);

  // ── 9. 튜너 (displayLarge 72sp 오버라이드는 앱에서 처리) ──
  static ThemeData tunerLight() =>
      AppThemeBase.light(seedColor: AppSeeds.tuner);
  static ThemeData tunerDark({bool amoled = false}) =>
      AppThemeBase.dark(seedColor: AppSeeds.tuner, amoled: amoled);

  // ── 10. 독서 기록 ──────────────────────────────────────────
  static ThemeData bookTrackerLight() =>
      AppThemeBase.light(seedColor: AppSeeds.bookTracker);
  static ThemeData bookTrackerDark({bool amoled = false}) =>
      AppThemeBase.dark(seedColor: AppSeeds.bookTracker, amoled: amoled);
}
