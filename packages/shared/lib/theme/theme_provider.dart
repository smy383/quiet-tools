import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── SharedPreferences 키 ─────────────────────────────────────────
const _kThemeModeKey = 'qt_theme_mode';
const _kAmoledKey    = 'qt_amoled';

// ── ThemeMode Provider ────────────────────────────────────────────

/// 현재 ThemeMode 상태 (system / light / dark)
///
/// 앱 재시작 시 SharedPreferences에서 복원됨
final themeModeProvider =
    AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_kThemeModeKey);
    return _fromString(value);
  }

  Future<void> setMode(ThemeMode mode) async {
    state = AsyncData(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeModeKey, _toString(mode));
  }

  Future<void> toggle() async {
    final current = state.valueOrNull ?? ThemeMode.system;
    final next = switch (current) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light  => ThemeMode.dark,
      ThemeMode.dark   => ThemeMode.system,
    };
    await setMode(next);
  }

  static ThemeMode _fromString(String? value) => switch (value) {
        'light'  => ThemeMode.light,
        'dark'   => ThemeMode.dark,
        _        => ThemeMode.system,
      };

  static String _toString(ThemeMode mode) => switch (mode) {
        ThemeMode.light  => 'light',
        ThemeMode.dark   => 'dark',
        ThemeMode.system => 'system',
      };
}

// ── AMOLED Provider ───────────────────────────────────────────────

/// AMOLED 모드 상태 (true: 순수 검정 배경)
///
/// 다크모드 활성 시에만 실제로 적용됨
final amoledModeProvider =
    AsyncNotifierProvider<AmoledModeNotifier, bool>(
  AmoledModeNotifier.new,
);

class AmoledModeNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kAmoledKey) ?? false;
  }

  Future<void> setAmoled(bool value) async {
    state = AsyncData(value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kAmoledKey, value);
  }

  Future<void> toggle() async {
    await setAmoled(!(state.valueOrNull ?? false));
  }
}
