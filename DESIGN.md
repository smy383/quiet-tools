# Quiet Tools — 디자인 가이드 v1.0

> Flutter 온디바이스 앱 10종 통합 디자인 시스템
> 마지막 업데이트: 2026-03-31

---

## 브랜드 이름: **Quiet Tools**
> 태그라인: *Offline. Always ready.*

---

## 1. 브랜드 컬러 토큰

```dart
// packages/shared/lib/theme/app_colors.dart
abstract class AppColors {
  // Neutral (공통 베이스)
  static const Color neutralDark     = Color(0xFF1A1C1E);
  static const Color neutralLight    = Color(0xFFE2E2E6);

  // Surface (Light)
  static const Color surfaceLight    = Color(0xFFF8F9FA);
  static const Color surfaceVarLight = Color(0xFFE1E2EC);
  static const Color outlineLight    = Color(0xFF74777F);
  static const Color adBannerLight   = Color(0xFFEEEFF3);

  // Surface (Dark)
  static const Color surfaceDark     = Color(0xFF121316);
  static const Color surfaceVarDark  = Color(0xFF44464F);
  static const Color outlineDark     = Color(0xFF8E9099);
  static const Color adBannerDark    = Color(0xFF1E1F23);

  // AMOLED 옵션
  static const Color surfaceAmoled   = Color(0xFF000000);
}
```

---

## 2. 앱별 Seed Color

```dart
// packages/shared/lib/theme/app_seeds.dart
abstract class AppSeeds {
  static const Color habitTracker   = Color(0xFF26A69A); // Teal
  static const Color expenseTracker = Color(0xFF3949AB); // Indigo
  static const Color journal        = Color(0xFFAD7FA8); // Mauve
  static const Color workoutLogger  = Color(0xFFF4511E); // Deep Orange
  static const Color unitConverter  = Color(0xFF5C6BC0); // Slate Blue
  static const Color loanCalculator = Color(0xFF00695C); // Dark Teal
  static const Color sleepSound     = Color(0xFF283593); // Midnight Indigo
  static const Color firstAid       = Color(0xFFC62828); // Safety Red
  static const Color tuner          = Color(0xFFF57F17); // Warm Amber
  static const Color bookTracker    = Color(0xFF6D4C41); // Warm Brown
}
```

### 앱별 컬러 + 특이사항

| # | 앱 | Seed | 특이사항 |
|---|-----|------|---------|
| 1 | 습관 추적기 | `#26A69A` Teal | — |
| 2 | 가계부 | `#3949AB` Indigo | Tabular figures |
| 3 | 일기/저널 | `#AD7FA8` Mauve | bodyLarge 18sp |
| 4 | 운동 기록기 | `#F4511E` Deep Orange | 달성 애니메이션 강조 |
| 5 | 단위 변환기 | `#5C6BC0` Slate Blue | — |
| 6 | 대출 계산기 | `#00695C` Dark Teal | Tabular figures |
| 7 | 백색소음 | `#283593` Midnight Indigo | **기본값 다크모드** |
| 8 | 응급처치 | `#C62828` Safety Red | **인터스티셜 없음**, 기본값 라이트모드 |
| 9 | 튜너 | `#F57F17` Warm Amber | displayLarge 72sp 주파수 표시 |
| 10 | 독서 기록 | `#6D4C41` Warm Brown | — |

---

## 3. 타이포그래피

### 폰트: NotoSansKR (3 웨이트 번들)
- Regular (400), Medium (500), Bold (700)
- ⚠️ `google_fonts` 패키지 사용 금지 (네트워크 요청 발생)
- Variable font(`NotoSansKR[wght].ttf`) 단일 파일로 대체 시 약 3MB 절약 가능

### 앱별 타이포 오버라이드
- **가계부 / 대출 계산기:** `FontFeature.tabularFigures()`
- **튜너:** 주파수 히어로 숫자 72sp Bold
- **일기/저널:** bodyLarge 18sp, height 1.75
- **응급처치:** 단계 번호 40sp Bold

---

## 4. 여백 체계

```dart
abstract class AppSpacing {
  static const double s4  = 4.0;   // 인라인 소간격
  static const double s8  = 8.0;   // 컴포넌트 내부
  static const double s12 = 12.0;  // 카드 내부 패딩
  static const double s16 = 16.0;  // 화면 좌우 패딩
  static const double s24 = 24.0;  // 섹션 간 여백
  static const double s32 = 32.0;  // 콘텐츠 블록 간
  static const double s48 = 48.0;  // 히어로 패딩
  static const double minTouchTarget = 48.0;
}
```

---

## 5. Shape 시스템

| 컴포넌트 | 라운드 |
|---------|--------|
| 카드 | 16dp |
| Filled 버튼 | 24dp (Pill) |
| Outlined 버튼 | 12dp |
| 입력 필드 | top 12dp |
| 바텀 시트 | top 28dp |
| 다이얼로그 | 28dp |
| FAB | 16dp |

---

## 6. UI 스타일 방향

- **Material 3** (`useMaterial3: true`)
- **미니멀 + 기능 중심** — 불필요한 장식 없음
- **다크모드 전체 지원** (시스템 설정 따름)
- **AMOLED 옵션** 설정에서 토글 가능
- **elevation 0** 카드 (그림자 없이 surface color 구분)
- 카드 상단 4dp 컬러 바로 앱 아이덴티티 강조

---

## 7. 아이콘

- 패키지: `material_symbols_icons`
- 비활성: `fill: 0`, 활성: `fill: 1`

| 앱 | 아이콘 |
|----|--------|
| 습관 추적기 | `Symbols.check_circle` |
| 가계부 | `Symbols.account_balance_wallet` |
| 일기/저널 | `Symbols.auto_stories` |
| 운동 기록기 | `Symbols.fitness_center` |
| 단위 변환기 | `Symbols.swap_horiz` |
| 대출 계산기 | `Symbols.calculate` |
| 백색소음 | `Symbols.bedtime` |
| 응급처치 | `Symbols.emergency` |
| 튜너 | `Symbols.music_note` |
| 독서 기록 | `Symbols.menu_book` |

---

## 8. 애니메이션

- 화면 전환: `SharedAxisTransition` (Z축, 250ms)
- 달성 피드백: `AnimatedScale` (1.2배, easeOutBack, 150ms)
- 숫자 변화: `AnimatedSwitcher` + `SlideTransition`
- 백색소음 Breathing: `AnimatedScale` 1.15배, 4000ms easeInOut

---

## 9. AdMob 배너 레이아웃

- 공통 `AppScaffold` 위젯으로 모든 앱에서 동일하게 처리
- 배너 높이: 50px (320x50 Standard Banner)
- 배너 배경: `surfaceContainerLow`
- 상단 구분선: `outlineVariant` 1dp
- 기본: **하단** 고정
- 예외 (백색소음, 튜너): 컨트롤 버튼 하단 배치 시 **상단**으로 이동

---

## 10. GitHub Pages 소개 페이지

- **다크 전용** UI (`background: #1A1C1E`)
- 앱별 컬러 바 (카드 상단 4dp) + hover 애니메이션
- Hero 섹션: "Quiet Tools / Offline. Always ready."
- 그라디언트 tagline: `#4FDBD1 → #B3C5FF`
- 앱 카드 그리드: `auto-fit, minmax(200px, 1fr)`

---

## 11. 테마 파일 구조

```
packages/shared/lib/theme/
├── app_colors.dart       ← 브랜드 컬러 상수
├── app_seeds.dart        ← 앱별 seed color
├── app_spacing.dart      ← 여백 시스템
├── app_shapes.dart       ← Shape 상수
├── app_typography.dart   ← TextTheme 빌더
├── app_theme_base.dart   ← 핵심 ThemeData 생성 (AppThemeBase 클래스)
├── app_themes.dart       ← 앱별 테마 인스턴스
└── theme_provider.dart   ← ThemeMode 상태 관리 (riverpod)

packages/shared/lib/widgets/
└── app_scaffold.dart     ← AdMob 배너 포함 공통 Scaffold
```

---

## 12. 추가 패키지

| 패키지 | 용도 |
|--------|------|
| `material_symbols_icons` | 아이콘 |
| `animations` | SharedAxisTransition 등 |
| `flutter_launcher_icons` | 앱 아이콘 (앱별 seed color 배경 + 흰 심볼) |
| `riverpod` | 테마 상태 관리 |

---

## ⚠️ 미확정 사항

| 항목 | 권장 방향 |
|------|-----------|
| WCAG AA 대비비 확인 | `flutter_color_contrast` 패키지로 개별 확인 |
| AMOLED 토글 구현 방식 | `ThemeExtension`으로 분리 |
| 폰트 용량 최적화 | Variable font 단일 파일 (약 3MB) 고려 |
| 태블릿 대응 | `LayoutBuilder` + 600dp 브레이크포인트, NavigationRail |
