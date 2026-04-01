import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';

import '../models/unit_category.dart';
import '../providers/conversion_provider.dart';
import '../widgets/conversion_result_tile.dart';

class ConversionScreen extends ConsumerStatefulWidget {
  const ConversionScreen({super.key, required this.category});

  final UnitCategory category;

  @override
  ConsumerState<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends ConsumerState<ConversionScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // 전달받은 category로 provider 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(conversionProvider.notifier).setCategory(widget.category);
    });
    _controller = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatInput(double v) {
    if (v == v.truncateToDouble()) return v.toInt().toString();
    return v.toString();
  }

  void _onInputChanged(String text) {
    final value = double.tryParse(text) ?? 0.0;
    ref.read(conversionProvider.notifier).setInputValue(value);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(conversionProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final results = state.results;

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          '${state.category.icon}  ${state.category.name}',
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // ── 입력 영역 ──────────────────────────────────────────
          Container(
            color: colorScheme.surfaceContainerLow,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s16,
              AppSpacing.s8,
              AppSpacing.s16,
              AppSpacing.s16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      labelText: '값 입력',
                      labelStyle: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: () {
                                _controller.clear();
                                _onInputChanged('0');
                              },
                            )
                          : null,
                    ),
                    onChanged: _onInputChanged,
                  ),
                ),
                const SizedBox(width: AppSpacing.s16),
                // ── 단위 선택 드롭다운 ────────────────────────
                DropdownButton<String>(
                  value: state.selectedUnitId,
                  underline: const SizedBox.shrink(),
                  borderRadius: BorderRadius.circular(12),
                  items: state.category.units.map((unit) {
                    return DropdownMenuItem(
                      value: unit.id,
                      child: Text(
                        unit.label,
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (id) {
                    if (id != null) {
                      ref
                          .read(conversionProvider.notifier)
                          .setSelectedUnit(id);
                    }
                  },
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colorScheme.outlineVariant),
          // ── 결과 리스트 ────────────────────────────────────────
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.s16),
              itemCount: state.category.units.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.s4),
              itemBuilder: (context, index) {
                final unit = state.category.units[index];
                final value = results[unit.id] ?? 0.0;
                final isSelected = unit.id == state.selectedUnitId;

                return ConversionResultTile(
                  unit: unit,
                  value: value,
                  isSelected: isSelected,
                  onTap: () {
                    ref
                        .read(conversionProvider.notifier)
                        .setSelectedUnit(unit.id);
                    // 선택된 단위의 값을 입력 필드에 반영
                    final newInput = _formatInput(value);
                    _controller.text = newInput;
                    _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: newInput.length),
                    );
                    ref
                        .read(conversionProvider.notifier)
                        .setInputValue(value);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
