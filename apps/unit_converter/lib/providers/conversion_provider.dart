import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/unit_category.dart';

// ── 상태 모델 ─────────────────────────────────────────────────────

class ConversionState {
  const ConversionState({
    required this.category,
    required this.inputValue,
    required this.selectedUnitId,
  });

  final UnitCategory category;
  final double inputValue;
  final String selectedUnitId;

  ConversionState copyWith({
    UnitCategory? category,
    double? inputValue,
    String? selectedUnitId,
  }) {
    return ConversionState(
      category: category ?? this.category,
      inputValue: inputValue ?? this.inputValue,
      selectedUnitId: selectedUnitId ?? this.selectedUnitId,
    );
  }

  /// 현재 입력값을 기준 단위로 변환한 값
  double get baseValue {
    final unit = category.units.firstWhere((u) => u.id == selectedUnitId);
    return unit.toBase(inputValue);
  }

  /// 모든 단위의 변환 결과 맵 {unitId: result}
  Map<String, double> get results {
    final base = baseValue;
    return {
      for (final unit in category.units) unit.id: unit.fromBase(base),
    };
  }
}

// ── Notifier ─────────────────────────────────────────────────────

class ConversionNotifier extends AutoDisposeNotifier<ConversionState> {
  @override
  ConversionState build() {
    // 기본: 길이 카테고리, 1m
    return ConversionState(
      category: kCategories.first,
      inputValue: 1.0,
      selectedUnitId: kCategories.first.units.first.id,
    );
  }

  void setCategory(UnitCategory category) {
    state = ConversionState(
      category: category,
      inputValue: 1.0,
      selectedUnitId: category.units.first.id,
    );
  }

  void setInputValue(double value) {
    state = state.copyWith(inputValue: value);
  }

  void setSelectedUnit(String unitId) {
    state = state.copyWith(selectedUnitId: unitId);
  }
}

// ── Providers ─────────────────────────────────────────────────────

final conversionProvider =
    AutoDisposeNotifierProvider<ConversionNotifier, ConversionState>(
  ConversionNotifier.new,
);
