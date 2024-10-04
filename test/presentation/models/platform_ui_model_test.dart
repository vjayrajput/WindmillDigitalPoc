import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/models/platform_ui_model.dart';

void main() {
  group('PlatformUiModel', () {
    const platform1 = PlatformUiModel(
      id: 1,
      name: 'Platform One',
      symbol: 'P1',
      slug: 'platform-one',
      tokenAddress: '0x1234567890abcdef',
    );

    const platform2 = PlatformUiModel(
      id: 1,
      name: 'Platform One',
      symbol: 'P1',
      slug: 'platform-one',
      tokenAddress: '0x1234567890abcdef',
    );

    const platform3 = PlatformUiModel(
      id: 2,
      name: 'Platform Two',
      symbol: 'P2',
      slug: 'platform-two',
      tokenAddress: '0xabcdef1234567890',
    );

    test('should create an instance of PlatformUiModel', () {
      expect(platform1, isA<PlatformUiModel>());
    });

    test('should be equal when properties are the same', () {
      expect(platform1, platform2);
    });

    test('should not be equal when properties are different', () {
      expect(platform1, isNot(platform3));
    });

    test('should return correct props', () {
      expect(platform1.props, [1, 'Platform One', 'P1', 'platform-one', '0x1234567890abcdef']);
    });
  });
}
