import 'package:flutter_test/flutter_test.dart';

import 'package:shared/shared.dart';

void main() {
  test('AppSpacing constants are positive', () {
    expect(AppSpacing.s4, greaterThan(0));
    expect(AppSpacing.s16, greaterThan(0));
    expect(AppSpacing.minTouchTarget, 48.0);
  });

  test('AppShapes constants are positive', () {
    expect(AppShapes.cardRadius, greaterThan(0));
    expect(AppShapes.dialogRadius, greaterThan(0));
  });
}
