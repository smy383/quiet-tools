enum UnitCategory { length, weight, temperature, area, volume, speed, data }

const Map<UnitCategory, String> categoryLabels = {
  UnitCategory.length: '길이',
  UnitCategory.weight: '무게',
  UnitCategory.temperature: '온도',
  UnitCategory.area: '넓이',
  UnitCategory.volume: '부피',
  UnitCategory.speed: '속도',
  UnitCategory.data: '데이터',
};

const Map<UnitCategory, String> categoryIcons = {
  UnitCategory.length: 'straighten',
  UnitCategory.weight: 'scale',
  UnitCategory.temperature: 'thermometer',
  UnitCategory.area: 'square_foot',
  UnitCategory.volume: 'water_drop',
  UnitCategory.speed: 'speed',
  UnitCategory.data: 'storage',
};

class UnitDef {
  final String id;
  final String label;
  final String symbol;
  final double toBase;

  const UnitDef({
    required this.id,
    required this.label,
    required this.symbol,
    required this.toBase,
  });
}

// base: 미터(m)
const _lengthUnits = [
  UnitDef(id: 'km', label: '킬로미터', symbol: 'km', toBase: 1000.0),
  UnitDef(id: 'm', label: '미터', symbol: 'm', toBase: 1.0),
  UnitDef(id: 'cm', label: '센티미터', symbol: 'cm', toBase: 0.01),
  UnitDef(id: 'mm', label: '밀리미터', symbol: 'mm', toBase: 0.001),
  UnitDef(id: 'inch', label: '인치', symbol: 'in', toBase: 0.0254),
  UnitDef(id: 'ft', label: '피트', symbol: 'ft', toBase: 0.3048),
  UnitDef(id: 'yard', label: '야드', symbol: 'yd', toBase: 0.9144),
  UnitDef(id: 'mile', label: '마일', symbol: 'mi', toBase: 1609.344),
  UnitDef(id: 'nm', label: '나노미터', symbol: 'nm', toBase: 1e-9),
];

// base: 킬로그램(kg)
const _weightUnits = [
  UnitDef(id: 'kg', label: '킬로그램', symbol: 'kg', toBase: 1.0),
  UnitDef(id: 'g', label: '그램', symbol: 'g', toBase: 0.001),
  UnitDef(id: 'mg', label: '밀리그램', symbol: 'mg', toBase: 1e-6),
  UnitDef(id: 'lb', label: '파운드', symbol: 'lb', toBase: 0.45359237),
  UnitDef(id: 'oz', label: '온스', symbol: 'oz', toBase: 0.028349523125),
  UnitDef(id: 't', label: '톤', symbol: 't', toBase: 1000.0),
];

// 온도: toBase는 사용 안 함 (특수 처리)
const _temperatureUnits = [
  UnitDef(id: 'c', label: '섭씨', symbol: '°C', toBase: 1.0),
  UnitDef(id: 'f', label: '화씨', symbol: '°F', toBase: 1.0),
  UnitDef(id: 'k', label: '켈빈', symbol: 'K', toBase: 1.0),
];

// base: m²
const _areaUnits = [
  UnitDef(id: 'm2', label: '제곱미터', symbol: 'm²', toBase: 1.0),
  UnitDef(id: 'km2', label: '제곱킬로미터', symbol: 'km²', toBase: 1e6),
  UnitDef(id: 'cm2', label: '제곱센티미터', symbol: 'cm²', toBase: 1e-4),
  UnitDef(id: 'mm2', label: '제곱밀리미터', symbol: 'mm²', toBase: 1e-6),
  UnitDef(id: 'ft2', label: '제곱피트', symbol: 'ft²', toBase: 0.09290304),
  UnitDef(id: 'acre', label: '에이커', symbol: 'ac', toBase: 4046.8564224),
  UnitDef(id: 'hectare', label: '헥타르', symbol: 'ha', toBase: 10000.0),
  UnitDef(id: 'pyeong', label: '평', symbol: '평', toBase: 3.3057851),
];

// base: 리터(L)
const _volumeUnits = [
  UnitDef(id: 'l', label: '리터', symbol: 'L', toBase: 1.0),
  UnitDef(id: 'ml', label: '밀리리터', symbol: 'mL', toBase: 0.001),
  UnitDef(id: 'm3', label: '세제곱미터', symbol: 'm³', toBase: 1000.0),
  UnitDef(id: 'ft3', label: '세제곱피트', symbol: 'ft³', toBase: 28.316846592),
  UnitDef(id: 'gallon', label: '갤런(US)', symbol: 'gal', toBase: 3.785411784),
  UnitDef(id: 'cup', label: '컵', symbol: 'cup', toBase: 0.2365882365),
  UnitDef(id: 'tbsp', label: '큰술', symbol: 'tbsp', toBase: 0.01478676478125),
  UnitDef(id: 'tsp', label: '작은술', symbol: 'tsp', toBase: 0.0049289215938),
];

// base: m/s
const _speedUnits = [
  UnitDef(id: 'ms', label: '미터/초', symbol: 'm/s', toBase: 1.0),
  UnitDef(id: 'kmh', label: '킬로미터/시', symbol: 'km/h', toBase: 0.27777778),
  UnitDef(id: 'mph', label: '마일/시', symbol: 'mph', toBase: 0.44704),
  UnitDef(id: 'knot', label: '노트', symbol: 'kn', toBase: 0.51444444),
  UnitDef(id: 'fts', label: '피트/초', symbol: 'ft/s', toBase: 0.3048),
];

// base: 바이트(byte) — 1024 기준
const _dataUnits = [
  UnitDef(id: 'byte', label: '바이트', symbol: 'B', toBase: 1.0),
  UnitDef(id: 'kb', label: '킬로바이트', symbol: 'KB', toBase: 1024.0),
  UnitDef(id: 'mb', label: '메가바이트', symbol: 'MB', toBase: 1048576.0),
  UnitDef(id: 'gb', label: '기가바이트', symbol: 'GB', toBase: 1073741824.0),
  UnitDef(id: 'tb', label: '테라바이트', symbol: 'TB', toBase: 1099511627776.0),
  UnitDef(id: 'bit', label: '비트', symbol: 'bit', toBase: 0.125),
];

const Map<UnitCategory, List<UnitDef>> unitDefs = {
  UnitCategory.length: _lengthUnits,
  UnitCategory.weight: _weightUnits,
  UnitCategory.temperature: _temperatureUnits,
  UnitCategory.area: _areaUnits,
  UnitCategory.volume: _volumeUnits,
  UnitCategory.speed: _speedUnits,
  UnitCategory.data: _dataUnits,
};
