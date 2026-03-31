import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_shapes.dart';
import 'app_typography.dart';

/// Quiet Tools 핵심 ThemeData 생성기
///
/// 모든 앱은 이 클래스를 통해 light/dark 테마를 생성한다.
/// - useMaterial3: true
/// - CardTheme elevation 0 (surface color로 구분)
/// - NotoSansKR 폰트 적용
abstract class AppThemeBase {
  // ── Light Theme ───────────────────────────────────────────────

  static ThemeData light({required Color seedColor}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
      surface: AppColors.surfaceLight,
    );
    return _build(colorScheme: colorScheme);
  }

  // ── Dark Theme ────────────────────────────────────────────────

  static ThemeData dark({required Color seedColor, bool amoled = false}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
      surface: amoled ? AppColors.surfaceAmoled : AppColors.surfaceDark,
    );
    return _build(
      colorScheme: colorScheme,
      scaffoldBackground: amoled ? AppColors.surfaceAmoled : null,
    );
  }

  // ── 공통 ThemeData 조립 ───────────────────────────────────────

  static ThemeData _build({
    required ColorScheme colorScheme,
    Color? scaffoldBackground,
  }) {
    final textTheme = AppTypography.buildTextTheme().apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: scaffoldBackground ?? colorScheme.surface,

      // ── Card ──────────────────────────────────────────────────
      cardTheme: CardThemeData(
        elevation: 0,
        shape: AppShapes.card(),
        color: colorScheme.surfaceContainerLow,
        clipBehavior: Clip.antiAlias,
      ),

      // ── AppBar ────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),

      // ── Filled Button ─────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: AppShapes.filledButton() as OutlinedBorder,
          minimumSize: const Size(0, 48),
        ),
      ),

      // ── Outlined Button ───────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: AppShapes.outlinedButton() as OutlinedBorder,
          minimumSize: const Size(0, 48),
        ),
      ),

      // ── Text Button ───────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(0, 48),
        ),
      ),

      // ── Input Decoration ──────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppShapes.inputTopRadius),
            topRight: Radius.circular(AppShapes.inputTopRadius),
          ),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // ── BottomSheet ───────────────────────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        shape: AppShapes.bottomSheet(),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),

      // ── Dialog ────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        shape: AppShapes.dialog(),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),

      // ── FAB ───────────────────────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: AppShapes.fab(),
      ),

      // ── Divider ───────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
