import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/models/platform_ui_model.dart';

void main() {
  group('CryptocurrencyUiModel', () {
    const platform = PlatformUiModel(
      id: 1,
      name: 'Ethereum',
      symbol: 'ETH',
      slug: 'ethereum',
      tokenAddress: '0x1234567890abcdef',
    );

    const crypto1 = CryptocurrencyUiModel(
      id: 1,
      name: 'Ethereum',
      symbol: 'ETH',
      slug: 'ethereum',
      rank: 2,
      isActive: 1,
      firstHistoricalData: '2015-07-30',
      lastHistoricalData: '2023-10-01',
      platform: platform,
    );

    const crypto2 = CryptocurrencyUiModel(
      id: 1,
      name: 'Ethereum',
      symbol: 'ETH',
      slug: 'ethereum',
      rank: 2,
      isActive: 1,
      firstHistoricalData: '2015-07-30',
      lastHistoricalData: '2023-10-01',
      platform: platform,
    );

    const crypto3 = CryptocurrencyUiModel(
      id: 2,
      name: 'Bitcoin',
      symbol: 'BTC',
      slug: 'bitcoin',
      rank: 1,
      isActive: 1,
      firstHistoricalData: '2010-07-17',
      lastHistoricalData: '2023-10-01',
      platform: null,
    );

    test('should create an instance of CryptocurrencyUiModel', () {
      expect(crypto1, isA<CryptocurrencyUiModel>());
    });

    test('should be equal when properties are the same', () {
      expect(crypto1, crypto2);
    });

    test('should not be equal when properties are different', () {
      expect(crypto1, isNot(crypto3));
    });

    test('should return correct props', () {
      expect(
        crypto1.props,
        [
          1,
          'Ethereum',
          'ETH',
          'ethereum',
          2,
          1,
          '2015-07-30',
          '2023-10-01',
        ],
      );
    });

    test('should handle null platform', () {
      expect(crypto3.platform, isNull);
    });
  });
}
