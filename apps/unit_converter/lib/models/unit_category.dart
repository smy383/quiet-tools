// 단위 변환기 — 카테고리 및 단위 정의
// 모든 변환은 SI 기준 단위로 중간 변환 후 결과 계산

/// 개별 단위 정의
class UnitDef {
  const UnitDef({
    required this.id,
    required this.label,
    required this.toBase,
    required this.fromBase,
  });

  /// 단위 고유 ID
  final String id;

  /// 화면에 표시할 이름 (예: "km", "°C")
  final String label;

  /// 해당 단위 값 → 기준 단위 변환 함수
  final double Function(double) toBase;

  /// 기준 단위 값 → 해당 단위 변환 함수
  final double Function(double) fromBase;
}

/// 카테고리 정의
class UnitCategory {
  const UnitCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.units,
  });

  final String id;
  final String name;
  final String icon;
  final List<UnitDef> units;
}

// ── 카테고리 목록 ─────────────────────────────────────────────────

const List<UnitCategory> kCategories = [
  _length,
  _weight,
  _temperature,
  _area,
  _volume,
  _speed,
  _time,
  _data,
  _pressure,
  _energy,
];

// ── 1. 길이 (기준: m) ─────────────────────────────────────────────

const _length = UnitCategory(
  id: 'length',
  name: '길이',
  icon: '📏',
  units: [
    UnitDef(
      id: 'km',
      label: 'km',
      toBase: _mul1000,
      fromBase: _div1000,
    ),
    UnitDef(
      id: 'm',
      label: 'm',
      toBase: _identity,
      fromBase: _identity,
    ),
    UnitDef(
      id: 'cm',
      label: 'cm',
      toBase: _div100,
      fromBase: _mul100,
    ),
    UnitDef(
      id: 'mm',
      label: 'mm',
      toBase: _div1000,
      fromBase: _mul1000,
    ),
    UnitDef(
      id: 'mile',
      label: 'mile',
      toBase: _milesToM,
      fromBase: _mToMiles,
    ),
    UnitDef(
      id: 'yard',
      label: 'yd',
      toBase: _yardsToM,
      fromBase: _mToYards,
    ),
    UnitDef(
      id: 'foot',
      label: 'ft',
      toBase: _feetToM,
      fromBase: _mToFeet,
    ),
    UnitDef(
      id: 'inch',
      label: 'in',
      toBase: _inchToM,
      fromBase: _mToInch,
    ),
  ],
);

// ── 2. 무게 (기준: kg) ────────────────────────────────────────────

const _weight = UnitCategory(
  id: 'weight',
  name: '무게',
  icon: '⚖️',
  units: [
    UnitDef(id: 'kg',  label: 'kg',  toBase: _identity,  fromBase: _identity),
    UnitDef(id: 'g',   label: 'g',   toBase: _div1000,   fromBase: _mul1000),
    UnitDef(id: 'mg',  label: 'mg',  toBase: _mgToKg,    fromBase: _kgToMg),
    UnitDef(id: 'ton', label: 't',   toBase: _mul1000,   fromBase: _div1000),
    UnitDef(id: 'lb',  label: 'lb',  toBase: _lbToKg,    fromBase: _kgToLb),
    UnitDef(id: 'oz',  label: 'oz',  toBase: _ozToKg,    fromBase: _kgToOz),
  ],
);

// ── 3. 온도 (기준: K) ─────────────────────────────────────────────

const _temperature = UnitCategory(
  id: 'temperature',
  name: '온도',
  icon: '🌡️',
  units: [
    UnitDef(id: 'celsius',    label: '°C', toBase: _cToK,     fromBase: _kToC),
    UnitDef(id: 'fahrenheit', label: '°F', toBase: _fToK,     fromBase: _kToF),
    UnitDef(id: 'kelvin',     label: 'K',  toBase: _identity, fromBase: _identity),
  ],
);

// ── 4. 넓이 (기준: m²) ───────────────────────────────────────────

const _area = UnitCategory(
  id: 'area',
  name: '넓이',
  icon: '⬛',
  units: [
    UnitDef(id: 'km2',  label: 'km²',  toBase: _km2ToM2,   fromBase: _m2ToKm2),
    UnitDef(id: 'm2',   label: 'm²',   toBase: _identity,  fromBase: _identity),
    UnitDef(id: 'cm2',  label: 'cm²',  toBase: _cm2ToM2,   fromBase: _m2ToCm2),
    UnitDef(id: 'ha',   label: 'ha',   toBase: _haToM2,    fromBase: _m2ToHa),
    UnitDef(id: 'acre', label: 'acre', toBase: _acreToM2,  fromBase: _m2ToAcre),
    UnitDef(id: 'ft2',  label: 'ft²',  toBase: _ft2ToM2,   fromBase: _m2ToFt2),
  ],
);

// ── 5. 부피 (기준: L) ─────────────────────────────────────────────

const _volume = UnitCategory(
  id: 'volume',
  name: '부피',
  icon: '🧴',
  units: [
    UnitDef(id: 'liter',  label: 'L',    toBase: _identity, fromBase: _identity),
    UnitDef(id: 'ml',     label: 'mL',   toBase: _div1000,  fromBase: _mul1000),
    UnitDef(id: 'm3',     label: 'm³',   toBase: _mul1000,  fromBase: _div1000),
    UnitDef(id: 'cm3',    label: 'cm³',  toBase: _div1000,  fromBase: _mul1000),
    UnitDef(id: 'gallon', label: 'gal',  toBase: _galToL,   fromBase: _lToGal),
    UnitDef(id: 'cup',    label: 'cup',  toBase: _cupToL,   fromBase: _lToCup),
    UnitDef(id: 'floz',   label: 'fl oz',toBase: _flozToL,  fromBase: _lToFloz),
  ],
);

// ── 6. 속도 (기준: m/s) ──────────────────────────────────────────

const _speed = UnitCategory(
  id: 'speed',
  name: '속도',
  icon: '💨',
  units: [
    UnitDef(id: 'kmh',  label: 'km/h', toBase: _kmhToMs,  fromBase: _msToKmh),
    UnitDef(id: 'ms',   label: 'm/s',  toBase: _identity, fromBase: _identity),
    UnitDef(id: 'mph',  label: 'mph',  toBase: _mphToMs,  fromBase: _msToMph),
    UnitDef(id: 'knot', label: 'kn',   toBase: _knotToMs, fromBase: _msToKnot),
  ],
);

// ── 7. 시간 (기준: 초) ────────────────────────────────────────────

const _time = UnitCategory(
  id: 'time',
  name: '시간',
  icon: '⏱️',
  units: [
    UnitDef(id: 'year',   label: '년',  toBase: _yearToS,  fromBase: _sToYear),
    UnitDef(id: 'month',  label: '월',  toBase: _monthToS, fromBase: _sToMonth),
    UnitDef(id: 'week',   label: '주',  toBase: _weekToS,  fromBase: _sToWeek),
    UnitDef(id: 'day',    label: '일',  toBase: _dayToS,   fromBase: _sToDay),
    UnitDef(id: 'hour',   label: '시',  toBase: _hourToS,  fromBase: _sToHour),
    UnitDef(id: 'minute', label: '분',  toBase: _minToS,   fromBase: _sToMin),
    UnitDef(id: 'second', label: '초',  toBase: _identity, fromBase: _identity),
  ],
);

// ── 8. 데이터 (기준: Byte) ────────────────────────────────────────

const _data = UnitCategory(
  id: 'data',
  name: '데이터',
  icon: '💾',
  units: [
    UnitDef(id: 'tb',   label: 'TB',   toBase: _tbToB,    fromBase: _bToTb),
    UnitDef(id: 'gb',   label: 'GB',   toBase: _gbToB,    fromBase: _bToGb),
    UnitDef(id: 'mb',   label: 'MB',   toBase: _mbToB,    fromBase: _bToMb),
    UnitDef(id: 'kb',   label: 'KB',   toBase: _kbToB,    fromBase: _bToKb),
    UnitDef(id: 'byte', label: 'Byte', toBase: _identity, fromBase: _identity),
    UnitDef(id: 'bit',  label: 'Bit',  toBase: _bitToB,   fromBase: _bToBit),
  ],
);

// ── 9. 압력 (기준: Pa) ───────────────────────────────────────────

const _pressure = UnitCategory(
  id: 'pressure',
  name: '압력',
  icon: '🔲',
  units: [
    UnitDef(id: 'pa',  label: 'Pa',  toBase: _identity, fromBase: _identity),
    UnitDef(id: 'kpa', label: 'kPa', toBase: _mul1000,  fromBase: _div1000),
    UnitDef(id: 'bar', label: 'bar', toBase: _barToPa,  fromBase: _paToBr),
    UnitDef(id: 'atm', label: 'atm', toBase: _atmToPa,  fromBase: _paToAtm),
    UnitDef(id: 'psi', label: 'psi', toBase: _psiToPa,  fromBase: _paToPsi),
  ],
);

// ── 10. 에너지 (기준: J) ─────────────────────────────────────────

const _energy = UnitCategory(
  id: 'energy',
  name: '에너지',
  icon: '⚡',
  units: [
    UnitDef(id: 'j',   label: 'J',   toBase: _identity, fromBase: _identity),
    UnitDef(id: 'kj',  label: 'kJ',  toBase: _mul1000,  fromBase: _div1000),
    UnitDef(id: 'cal', label: 'cal', toBase: _calToJ,   fromBase: _jToCal),
    UnitDef(id: 'kcal',label: 'kcal',toBase: _kcalToJ,  fromBase: _jToKcal),
    UnitDef(id: 'wh',  label: 'Wh',  toBase: _whToJ,    fromBase: _jToWh),
    UnitDef(id: 'kwh', label: 'kWh', toBase: _kwhToJ,   fromBase: _jToKwh),
  ],
);

// ── 변환 함수 (const 가능한 최상위 함수) ─────────────────────────

double _identity(double v) => v;
double _mul100(double v)   => v * 100;
double _div100(double v)   => v / 100;
double _mul1000(double v)  => v * 1000;
double _div1000(double v)  => v / 1000;

// 길이
double _milesToM(double v) => v * 1609.344;
double _mToMiles(double v) => v / 1609.344;
double _yardsToM(double v) => v * 0.9144;
double _mToYards(double v) => v / 0.9144;
double _feetToM(double v)  => v * 0.3048;
double _mToFeet(double v)  => v / 0.3048;
double _inchToM(double v)  => v * 0.0254;
double _mToInch(double v)  => v / 0.0254;

// 무게
double _mgToKg(double v) => v / 1_000_000;
double _kgToMg(double v) => v * 1_000_000;
double _lbToKg(double v) => v * 0.45359237;
double _kgToLb(double v) => v / 0.45359237;
double _ozToKg(double v) => v * 0.028349523125;
double _kgToOz(double v) => v / 0.028349523125;

// 온도
double _cToK(double v) => v + 273.15;
double _kToC(double v) => v - 273.15;
double _fToK(double v) => (v - 32) * 5 / 9 + 273.15;
double _kToF(double v) => (v - 273.15) * 9 / 5 + 32;

// 넓이
double _km2ToM2(double v)  => v * 1_000_000;
double _m2ToKm2(double v)  => v / 1_000_000;
double _cm2ToM2(double v)  => v / 10_000;
double _m2ToCm2(double v)  => v * 10_000;
double _haToM2(double v)   => v * 10_000;
double _m2ToHa(double v)   => v / 10_000;
double _acreToM2(double v) => v * 4046.8564224;
double _m2ToAcre(double v) => v / 4046.8564224;
double _ft2ToM2(double v)  => v * 0.09290304;
double _m2ToFt2(double v)  => v / 0.09290304;

// 부피
double _galToL(double v)  => v * 3.785411784;
double _lToGal(double v)  => v / 3.785411784;
double _cupToL(double v)  => v * 0.2365882365;
double _lToCup(double v)  => v / 0.2365882365;
double _flozToL(double v) => v * 0.0295735296;
double _lToFloz(double v) => v / 0.0295735296;

// 속도
double _kmhToMs(double v)  => v / 3.6;
double _msToKmh(double v)  => v * 3.6;
double _mphToMs(double v)  => v * 0.44704;
double _msToMph(double v)  => v / 0.44704;
double _knotToMs(double v) => v * 0.514444;
double _msToKnot(double v) => v / 0.514444;

// 시간
double _yearToS(double v)  => v * 31_536_000;
double _sToYear(double v)  => v / 31_536_000;
double _monthToS(double v) => v * 2_592_000;
double _sToMonth(double v) => v / 2_592_000;
double _weekToS(double v)  => v * 604_800;
double _sToWeek(double v)  => v / 604_800;
double _dayToS(double v)   => v * 86_400;
double _sToDay(double v)   => v / 86_400;
double _hourToS(double v)  => v * 3_600;
double _sToHour(double v)  => v / 3_600;
double _minToS(double v)   => v * 60;
double _sToMin(double v)   => v / 60;

// 데이터
double _tbToB(double v) => v * 1_099_511_627_776;
double _bToTb(double v) => v / 1_099_511_627_776;
double _gbToB(double v) => v * 1_073_741_824;
double _bToGb(double v) => v / 1_073_741_824;
double _mbToB(double v) => v * 1_048_576;
double _bToMb(double v) => v / 1_048_576;
double _kbToB(double v) => v * 1_024;
double _bToKb(double v) => v / 1_024;
double _bitToB(double v) => v / 8;
double _bToBit(double v) => v * 8;

// 압력
double _barToPa(double v)  => v * 100_000;
double _paToBr(double v)   => v / 100_000;
double _atmToPa(double v)  => v * 101_325;
double _paToAtm(double v)  => v / 101_325;
double _psiToPa(double v)  => v * 6894.757293168;
double _paToPsi(double v)  => v / 6894.757293168;

// 에너지
double _calToJ(double v)  => v * 4.184;
double _jToCal(double v)  => v / 4.184;
double _kcalToJ(double v) => v * 4184;
double _jToKcal(double v) => v / 4184;
double _whToJ(double v)   => v * 3600;
double _jToWh(double v)   => v / 3600;
double _kwhToJ(double v)  => v * 3_600_000;
double _jToKwh(double v)  => v / 3_600_000;
