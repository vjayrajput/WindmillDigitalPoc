import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/domain/entities/platform_entity.dart';

import '../../testing_data.dart';

void main() {
  group('PlatformEntity', () {
    test('should return true when two PlatformEntity instances are equal', () {
      const platform1 = PlatformEntity(
        id: 1,
        name: 'Ethereum',
        symbol: 'ETH',
        slug: 'ethereum',
        tokenAddress: '0x1234567890abcdef',
      );

      const platform2 = PlatformEntity(
        id: 1,
        name: 'Ethereum',
        symbol: 'ETH',
        slug: 'ethereum',
        tokenAddress: '0x1234567890abcdef',
      );

      expect(platform1, platform2);
    });

    test('should return false when two PlatformEntity instances are not equal',
        () {
      const platform1 = testPlatformEntity1;

      const platform2 = testPlatformEntity2;

      expect(platform1, isNot(platform2));
    });
  });
}
