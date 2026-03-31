import 'package:flutter/material.dart';

/// Quiet Tools Shape 시스템 (Material 3 기반)
abstract class AppShapes {
  // ── 반지름 상수 ───────────────────────────────────────────────
  static const double cardRadius         = 16.0;
  static const double filledButtonRadius = 24.0; // Pill
  static const double outlinedButtonRadius = 12.0;
  static const double inputTopRadius     = 12.0;
  static const double bottomSheetRadius  = 28.0;
  static const double dialogRadius       = 28.0;
  static const double fabRadius          = 16.0;

  // ── ShapeBorder 팩토리 ───────────────────────────────────────

  static ShapeBorder card() => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(cardRadius),
  );

  static ShapeBorder filledButton() => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(filledButtonRadius),
  );

  static ShapeBorder outlinedButton() => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(outlinedButtonRadius),
  );

  static ShapeBorder input() => RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(inputTopRadius),
      topRight: Radius.circular(inputTopRadius),
    ),
  );

  static ShapeBorder bottomSheet() => RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(bottomSheetRadius),
    ),
  );

  static ShapeBorder dialog() => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(dialogRadius),
  );

  static ShapeBorder fab() => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(fabRadius),
  );

  // ── BorderRadius 편의 접근 ────────────────────────────────────

  static BorderRadius get cardBorderRadius =>
      BorderRadius.circular(cardRadius);

  static BorderRadius get bottomSheetBorderRadius => BorderRadius.vertical(
        top: Radius.circular(bottomSheetRadius),
      );
}
