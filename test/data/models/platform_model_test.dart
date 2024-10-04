import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/data/models/platform_model.dart';

import '../../testing_data.dart';

void main() {
  group('PlatformModel Tests', () {
    test('PlatformModel fromJson should return a valid model', () {
      // Arrange
      final jsonMap = {
        'id': 1,
        'name': 'Ethereum',
        'symbol': 'ETH',
        'slug': 'ethereum',
        'tokenAddress': '0x1234567890abcdef'
      };

      // Act
      final platform = PlatformModel.fromJson(jsonMap);

      // Assert
      expect(platform.id, 1);
      expect(platform.name, 'Ethereum');
      expect(platform.symbol, 'ETH');
      expect(platform.slug, 'ethereum');
      expect(platform.tokenAddress, '0x1234567890abcdef');
    });

    test('PlatformModel toJson should return a valid JSON', () {
      // Arrange
      final platform = testPlatformModel1;

      // Act
      final jsonMap = platform.toJson();

      // Assert
      expect(jsonMap['id'], 1);
      expect(jsonMap['name'], 'Ethereum');
      expect(jsonMap['symbol'], 'ETH');
      expect(jsonMap['slug'], 'ethereum');
      expect(jsonMap['tokenAddress'], '0x1234567890abcdef');
    });

    test('PlatformModel Hive field should have correct type', () {
      final platform = testPlatformModel1;

      expect(platform.id.runtimeType, int);
      expect(platform.name.runtimeType, String);
    });
  });
}
