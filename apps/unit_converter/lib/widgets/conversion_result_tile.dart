import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/unit_category.dart';

class ConversionResultTile extends StatelessWidget {
  const ConversionResultTile({
    super.key,
    required this.unit,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  final UnitDef unit;
  final double value;
  final bool isSelected;
  final VoidCallback onTap;

  String _formatValue(double v) {
    if (v.isInfinite || v.isNaN) return '—';
    if (v == 0) return '0';

    final abs = v.abs();
    if (abs >= 1e12 || (abs < 1e-6 && abs > 0)) {
      return v.toStringAsExponential(4);
    }
    if (abs >= 1000) {
      return v.toStringAsFixed(4).replaceAll(RegExp(r'\.?0+$'), '');
    }
    return v.toStringAsFixed(6).replaceAll(RegExp(r'\.?0+$'), '');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final formattedValue = _formatValue(value);

    return Material(
      color: isSelected
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: '$formattedValue ${unit.label}'));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${unit.label} 값을 복사했습니다'),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 52,
                alignment: Alignment.centerLeft,
                child: Text(
                  unit.label,
                  style: textTheme.labelLarge?.copyWith(
                    color: isSelected
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  formattedValue,
                  style: textTheme.bodyLarge?.copyWith(
                    color: isSelected
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.check_circle_rounded,
                  size: 18,
                  color: colorScheme.primary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
