import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared/shared.dart';
import '../data/unit_definitions.dart';
import '../domain/conversion_logic.dart';
import '../providers/converter_provider.dart';
import 'widgets/category_selector.dart';
import '../../../ads/interstitial_manager.dart';

class ConverterPage extends ConsumerStatefulWidget {
  const ConverterPage({super.key});

  @override
  ConsumerState<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends ConsumerState<ConverterPage> {
  final _inputController = TextEditingController();
  final _inputFocus = FocusNode();
  String _lastInput = '';

  @override
  void dispose() {
    _inputController.dispose();
    _inputFocus.dispose();
    super.dispose();
  }

  void _onInputChanged(String text) {
    if (text == _lastInput) return;
    _lastInput = text;
    ref.read(converterProvider.notifier).setInput(text);

    // 실제 결과가 변경될 때만 카운트 증가
    final state = ref.read(converterProvider);
    if (state.result != null) {
      final count = ref.read(conversionCountProvider.notifier).state + 1;
      ref.read(conversionCountProvider.notifier).state = count;
      ref.read(interstitialManagerProvider).tryShow(count);
    }
  }

  void _onCategoryChanged() {
    _inputController.clear();
    _lastInput = '';
    ref.read(converterProvider.notifier).setInput('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 카테고리 변경 감지 → 입력 초기화
    ref.listen(converterProvider, (prev, next) {
      if (prev?.category != next.category) {
        _onCategoryChanged();
      }
    });

    final state = ref.watch(converterProvider);
    final units = unitDefs[state.category]!;

    return AppScaffold(
      adBannerPosition: AdBannerPosition.bottom,
      appBar: AppBar(
        title: const Text('단위 변환기'),
        actions: [
          _ThemeToggleButton(),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const CategorySelector(),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // 입력 카드
                  _InputCard(
                    controller: _inputController,
                    focusNode: _inputFocus,
                    units: units,
                    selectedUnit: state.fromUnit,
                    onUnitChanged: (unit) {
                      if (unit != null) {
                        ref.read(converterProvider.notifier).setFromUnit(unit);
                      }
                    },
                    onInputChanged: _onInputChanged,
                    label: '변환할 값',
                  ),
                  const SizedBox(height: 8),
                  // 스왑 버튼
                  _SwapButton(
                    onTap: () {
                      final state = ref.read(converterProvider);
                      ref.read(converterProvider.notifier).swapUnits();
                      // 스왑 후 입력 필드 업데이트
                      if (state.result != null) {
                        final newText = formatResult(state.result!);
                        _inputController.text = newText;
                        _inputController.selection = TextSelection.collapsed(
                          offset: newText.length,
                        );
                        _lastInput = newText;
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  // 결과 카드
                  _ResultCard(
                    state: state,
                    units: units,
                    onUnitChanged: (unit) {
                      if (unit != null) {
                        ref.read(converterProvider.notifier).setToUnit(unit);
                      }
                    },
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 입력 카드 ──────────────────────────────────────────────────────

class _InputCard extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<UnitDef> units;
  final UnitDef selectedUnit;
  final ValueChanged<UnitDef?> onUnitChanged;
  final ValueChanged<String> onInputChanged;
  final String label;

  const _InputCard({
    required this.controller,
    required this.focusNode,
    required this.units,
    required this.selectedUnit,
    required this.onUnitChanged,
    required this.onInputChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            )),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^-?\d*\.?\d*'),
                      ),
                    ],
                    style: theme.textTheme.headlineSmall,
                    decoration: const InputDecoration(
                      hintText: '0',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                    onChanged: onInputChanged,
                  ),
                ),
                const SizedBox(width: 8),
                _UnitDropdown(
                  units: units,
                  selected: selectedUnit,
                  onChanged: onUnitChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 결과 카드 ──────────────────────────────────────────────────────

class _ResultCard extends StatelessWidget {
  final ConverterState state;
  final List<UnitDef> units;
  final ValueChanged<UnitDef?> onUnitChanged;
  final ColorScheme colorScheme;

  const _ResultCard({
    required this.state,
    required this.units,
    required this.onUnitChanged,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resultText = state.result != null
        ? formatResult(state.result!)
        : (state.inputText.isEmpty ? '' : '—');

    return Card(
      color: colorScheme.secondaryContainer.withAlpha(77),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('변환 결과', style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            )),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    resultText.isEmpty ? '0' : resultText,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: resultText.isEmpty
                          ? colorScheme.onSurface.withAlpha(77)
                          : colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _UnitDropdown(
                  units: units,
                  selected: state.toUnit,
                  onChanged: onUnitChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 단위 드롭다운 ──────────────────────────────────────────────────

class _UnitDropdown extends StatelessWidget {
  final List<UnitDef> units;
  final UnitDef selected;
  final ValueChanged<UnitDef?> onChanged;

  const _UnitDropdown({
    required this.units,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButton<UnitDef>(
      value: selected,
      underline: const SizedBox(),
      isDense: true,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      items: units.map((unit) {
        return DropdownMenuItem<UnitDef>(
          value: unit,
          child: Text('${unit.symbol}  ${unit.label}'),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

// ─── 스왑 버튼 ──────────────────────────────────────────────────────

class _SwapButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SwapButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton.outlined(
        onPressed: onTap,
        icon: const Icon(Symbols.swap_vert),
        tooltip: '단위 교환',
      ),
    );
  }
}

// ─── 테마 토글 버튼 ─────────────────────────────────────────────────

class _ThemeToggleButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final themeMode = themeModeAsync.valueOrNull ?? ThemeMode.system;

    IconData icon;
    String tooltip;
    switch (themeMode) {
      case ThemeMode.light:
        icon = Symbols.light_mode;
        tooltip = '라이트 모드';
        break;
      case ThemeMode.dark:
        icon = Symbols.dark_mode;
        tooltip = '다크 모드';
        break;
      default:
        icon = Symbols.brightness_auto;
        tooltip = '시스템 설정';
    }

    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: () {
        ref.read(themeModeProvider.notifier).toggle();
      },
    );
  }
}
