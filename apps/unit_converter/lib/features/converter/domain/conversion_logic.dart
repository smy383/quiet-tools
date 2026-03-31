import '../data/unit_definitions.dart';

/// 단위 변환 메인 함수
/// 온도는 비선형이므로 특수 처리, 그 외는 toBase 계수 활용
double convert({
  required UnitCategory category,
  required UnitDef from,
  required UnitDef to,
  required double value,
}) {
  if (category == UnitCategory.temperature) {
    return _convertTemperature(from.id, to.id, value);
  }
  // 일반 선형 변환: value → base → to
  final base = value * from.toBase;
  return base / to.toBase;
}

double _convertTemperature(String fromId, String toId, double value) {
  if (fromId == toId) return value;

  // 먼저 섭씨(C)로 변환
  final celsius = _toCelsius(fromId, value);
  // 섭씨 → 목표 단위
  return _fromCelsius(toId, celsius);
}

double _toCelsius(String fromId, double value) {
  switch (fromId) {
    case 'c':
      return value;
    case 'f':
      return (value - 32) * 5 / 9;
    case 'k':
      return value - 273.15;
    default:
      return value;
  }
}

double _fromCelsius(String toId, double celsius) {
  switch (toId) {
    case 'c':
      return celsius;
    case 'f':
      return celsius * 9 / 5 + 32;
    case 'k':
      return celsius + 273.15;
    default:
      return celsius;
  }
}

/// 결과값을 사람이 읽기 좋은 형태로 포맷
String formatResult(double value) {
  if (value == 0) return '0';

  final abs = value.abs();

  // 매우 크거나 매우 작으면 지수 표기
  if (abs != 0 && (abs >= 1e12 || abs < 1e-6)) {
    return _formatScientific(value);
  }

  // 정수에 가까우면 소수점 제거
  if (abs >= 1000) {
    final rounded = double.parse(value.toStringAsFixed(4));
    if (rounded == rounded.roundToDouble()) {
      return rounded.toInt().toString();
    }
    return _trimTrailingZeros(value.toStringAsFixed(4));
  }

  if (abs >= 1) {
    return _trimTrailingZeros(value.toStringAsFixed(6));
  }

  return _trimTrailingZeros(value.toStringAsFixed(8));
}

String _trimTrailingZeros(String s) {
  if (!s.contains('.')) return s;
  s = s.replaceAll(RegExp(r'0+$'), '');
  if (s.endsWith('.')) s = s.substring(0, s.length - 1);
  return s;
}

String _formatScientific(double value) {
  final str = value.toStringAsExponential(4);
  // 지수 표기에서 trailing zero 제거
  final parts = str.split('e');
  if (parts.length == 2) {
    return '${_trimTrailingZeros(parts[0])}e${parts[1]}';
  }
  return str;
}
