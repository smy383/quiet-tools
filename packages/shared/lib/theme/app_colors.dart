import 'package:flutter/material.dart';

/// Quiet Tools 브랜드 컬러 토큰
abstract class AppColors {
  // ── Neutral (공통 베이스) ─────────────────────────────────────
  static const Color neutralDark  = Color(0xFF1A1C1E);
  static const Color neutralLight = Color(0xFFE2E2E6);

  // ── Surface (Light) ──────────────────────────────────────────
  static const Color surfaceLight    = Color(0xFFF8F9FA);
  static const Color surfaceVarLight = Color(0xFFE1E2EC);
  static const Color outlineLight    = Color(0xFF74777F);
  static const Color adBannerLight   = Color(0xFFEEEFF3);

  // ── Surface (Dark) ───────────────────────────────────────────
  static const Color surfaceDark    = Color(0xFF121316);
  static const Color surfaceVarDark = Color(0xFF44464F);
  static const Color outlineDark    = Color(0xFF8E9099);
  static const Color adBannerDark   = Color(0xFF1E1F23);

  // ── AMOLED 옵션 ──────────────────────────────────────────────
  static const Color surfaceAmoled = Color(0xFF000000);
}
