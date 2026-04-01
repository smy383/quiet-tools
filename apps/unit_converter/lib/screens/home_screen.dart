import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';

import '../models/unit_category.dart';
import '../widgets/category_card.dart';
import 'conversion_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('단위 변환기'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6_rounded),
            tooltip: '테마 변경',
            onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.s8,
            mainAxisSpacing: AppSpacing.s8,
            childAspectRatio: 1.1,
          ),
          itemCount: kCategories.length,
          itemBuilder: (context, index) {
            final category = kCategories[index];
            return CategoryCard(
              category: category,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ConversionScreen(category: category),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
