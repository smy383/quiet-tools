import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';
import 'features/converter/ui/converter_page.dart';

class UnitConverterApp extends ConsumerWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final amoledAsync = ref.watch(amoledModeProvider);

    final themeMode = themeModeAsync.valueOrNull ?? ThemeMode.system;
    final amoled = amoledAsync.valueOrNull ?? false;

    return MaterialApp(
      title: '단위 변환기',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.unitConverterLight(),
      darkTheme: AppThemes.unitConverterDark(amoled: amoled),
      themeMode: themeMode,
      home: const ConverterPage(),
    );
  }
}
