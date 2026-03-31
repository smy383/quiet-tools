import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../data/unit_definitions.dart';
import '../../providers/converter_provider.dart';

class CategorySelector extends ConsumerWidget {
  const CategorySelector({super.key});

  IconData _iconForCategory(UnitCategory category) {
    switch (category) {
      case UnitCategory.length:
        return Symbols.straighten;
      case UnitCategory.weight:
        return Symbols.scale;
      case UnitCategory.temperature:
        return Symbols.device_thermostat;
      case UnitCategory.area:
        return Symbols.square_foot;
      case UnitCategory.volume:
        return Symbols.water_drop;
      case UnitCategory.speed:
        return Symbols.speed;
      case UnitCategory.data:
        return Symbols.storage;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(converterProvider);
    final selectedCategory = state.category;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: UnitCategory.values.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = UnitCategory.values[index];
          final isSelected = category == selectedCategory;
          final label = categoryLabels[category]!;
          final icon = _iconForCategory(category);

          return FilterChip(
            selected: isSelected,
            showCheckmark: false,
            avatar: Icon(
              icon,
              size: 16,
              fill: isSelected ? 1.0 : 0.0,
            ),
            label: Text(label),
            onSelected: (_) {
              if (!isSelected) {
                ref.read(converterProvider.notifier).setCategory(category);
                ref.read(lastCategoryProvider.notifier).save(category);
              }
            },
          );
        },
      ),
    );
  }
}
