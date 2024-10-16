import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';

import '../../testing_data.dart';

void main() {
  group('CryptocurrencyEntity', () {
    test('should return true when two CryptocurrencyEntity instances are equal',
        () {
      const platform = testPlatformEntity1;

      const crypto1 = CryptocurrencyEntity(
        id: 1,
        name: 'Ethereum',
        symbol: 'ETH',
        slug: 'ethereum',
        rank: 2,
        isActive: 1,
        firstHistoricalData: '2015-07-30',
        lastHistoricalData: '2024-10-01',
        platform: platform,
      );

      const crypto2 = CryptocurrencyEntity(
        id: 1,
        name: 'Ethereum',
        symbol: 'ETH',
        slug: 'ethereum',
        rank: 2,
        isActive: 1,
        firstHistoricalData: '2015-07-30',
        lastHistoricalData: '2024-10-01',
        platform: platform,
      );

      expect(crypto1, crypto2);
    });

    test(
        'should return false when two CryptocurrencyEntity instances are not equal',
        () {
      const crypto1 = testCryptocurrencyEntity1;

      const crypto2 = testCryptocurrencyEntity2;

      expect(crypto1, isNot(crypto2));
    });
  });
}
