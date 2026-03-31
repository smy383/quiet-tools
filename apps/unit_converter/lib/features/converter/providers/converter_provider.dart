import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/unit_definitions.dart';
import '../domain/conversion_logic.dart';

// ─── 마지막 카테고리 저장/복원 ─────────────────────────────────────

const _lastCategoryKey = 'uc_last_category';

class LastCategoryNotifier extends AsyncNotifier<UnitCategory> {
  @override
  Future<UnitCategory> build() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_lastCategoryKey);
    if (saved != null) {
      try {
        return UnitCategory.values.firstWhere((e) => e.name == saved);
      } catch (_) {}
    }
    return UnitCategory.length;
  }

  Future<void> save(UnitCategory category) async {
    state = AsyncValue.data(category);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastCategoryKey, category.name);
  }
}

final lastCategoryProvider =
    AsyncNotifierProvider<LastCategoryNotifier, UnitCategory>(
  LastCategoryNotifier.new,
);

// ─── 변환 상태 ────────────────────────────────────────────────────

class ConverterState {
  final UnitCategory category;
  final UnitDef fromUnit;
  final UnitDef toUnit;
  final String inputText;
  final double? result;

  const ConverterState({
    required this.category,
    required this.fromUnit,
    required this.toUnit,
    required this.inputText,
    this.result,
  });

  ConverterState copyWith({
    UnitCategory? category,
    UnitDef? fromUnit,
    UnitDef? toUnit,
    String? inputText,
    double? result,
    bool clearResult = false,
  }) {
    return ConverterState(
      category: category ?? this.category,
      fromUnit: fromUnit ?? this.fromUnit,
      toUnit: toUnit ?? this.toUnit,
      inputText: inputText ?? this.inputText,
      result: clearResult ? null : (result ?? this.result),
    );
  }
}

ConverterState _initialState(UnitCategory category) {
  final units = unitDefs[category]!;
  return ConverterState(
    category: category,
    fromUnit: units[0],
    toUnit: units.length > 1 ? units[1] : units[0],
    inputText: '',
    result: null,
  );
}

class ConverterNotifier extends StateNotifier<ConverterState> {
  ConverterNotifier(UnitCategory initialCategory)
      : super(_initialState(initialCategory));

  void setCategory(UnitCategory category) {
    state = _initialState(category);
  }

  void setFromUnit(UnitDef unit) {
    final newState = state.copyWith(fromUnit: unit);
    state = _recalculate(newState);
  }

  void setToUnit(UnitDef unit) {
    final newState = state.copyWith(toUnit: unit);
    state = _recalculate(newState);
  }

  void setInput(String text) {
    final newState = state.copyWith(inputText: text);
    state = _recalculate(newState);
  }

  void swapUnits() {
    final resultText =
        state.result != null ? formatResult(state.result!) : state.inputText;
    final newState = ConverterState(
      category: state.category,
      fromUnit: state.toUnit,
      toUnit: state.fromUnit,
      inputText: resultText,
      result: null,
    );
    state = _recalculate(newState);
  }

  ConverterState _recalculate(ConverterState s) {
    if (s.inputText.isEmpty) {
      return s.copyWith(clearResult: true);
    }
    final value = double.tryParse(s.inputText);
    if (value == null) {
      return s.copyWith(clearResult: true);
    }
    final result = convert(
      category: s.category,
      from: s.fromUnit,
      to: s.toUnit,
      value: value,
    );
    return s.copyWith(result: result);
  }
}

final converterProvider =
    StateNotifierProvider<ConverterNotifier, ConverterState>((ref) {
  final categoryAsync = ref.watch(lastCategoryProvider);
  final category = categoryAsync.valueOrNull ?? UnitCategory.length;
  return ConverterNotifier(category);
});

// ─── 변환 횟수 (인터스티셜 트리거) ───────────────────────────────────

final conversionCountProvider = StateProvider<int>((ref) => 0);
