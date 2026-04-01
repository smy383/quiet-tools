import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared/shared.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const ProviderScope(child: UnitConverterApp()));
}

class UnitConverterApp extends ConsumerWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;
    final amoled = ref.watch(amoledModeProvider).valueOrNull ?? false;

    return MaterialApp(
      title: '단위 변환기',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.unitConverterLight(),
      darkTheme: AppThemes.unitConverterDark(amoled: amoled),
      themeMode: themeMode,
      home: const HomeScreen(),
    );
  }
}
