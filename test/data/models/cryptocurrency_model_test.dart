import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

import '../../testing_data.dart';

void main() {
  group('CryptocurrencyModel Tests', () {
    test('CryptocurrencyModel fromJson should return a valid model', () {
      // Arrange
      final jsonMap = {
        'id': 1,
        'rank': 1,
        'name': 'Bitcoin',
        'symbol': 'BTC',
        'slug': 'bitcoin',
        'isActive': 1,
        'firstHistoricalData': '2015-02-25T13:34:26.000Z',
        'lastHistoricalData': '2020-05-05T20:44:01.000Z',
        'platform': {
          'id': 1,
          'name': 'Ethereum',
          'symbol': 'ETH',
          'slug': 'ethereum',
          'tokenAddress': '0x1234567890abcdef'
        }
      };

      // Act
      final cryptocurrency = CryptocurrencyModel.fromJson(jsonMap);

      // Assert
      expect(cryptocurrency.id, 1);
      expect(cryptocurrency.rank, 1);
      expect(cryptocurrency.name, 'Bitcoin');
      expect(cryptocurrency.symbol, 'BTC');
      expect(cryptocurrency.slug, 'bitcoin');
      expect(cryptocurrency.isActive, 1);
      expect(cryptocurrency.firstHistoricalData, '2015-02-25T13:34:26.000Z');
      expect(cryptocurrency.lastHistoricalData, '2020-05-05T20:44:01.000Z');
      expect(cryptocurrency.platform?.name, 'Ethereum');
    });

    test('CryptocurrencyModel toJson should return a valid JSON', () {
      // Arrange
      final platform = testPlatformModel2;

      final cryptocurrency = CryptocurrencyModel(
        id: 1,
        rank: 1,
        name: 'Bitcoin',
        symbol: 'BTC',
        slug: 'bitcoin',
        isActive: 1,
        firstHistoricalData: "2015-02-25T13:34:26.000Z",
        lastHistoricalData: "2020-05-05T20:44:01.000Z",
        platform: platform,
      );

      // Act
      final jsonMap = cryptocurrency.toJson();

      // Assert
      expect(jsonMap['id'], 1);
      expect(jsonMap['rank'], 1);
      expect(jsonMap['name'], 'Bitcoin');
      expect(jsonMap['symbol'], 'BTC');
      expect(jsonMap['slug'], 'bitcoin');
      expect(jsonMap['isActive'], 1);
      expect(jsonMap['firstHistoricalData'], '2015-02-25T13:34:26.000Z');
      expect(jsonMap['lastHistoricalData'], '2020-05-05T20:44:01.000Z');
    });

    test('CryptocurrencyModel Hive field validation', () {
      // Arrange
      final platform = testPlatformModel1;

      final cryptocurrency = CryptocurrencyModel(
        id: 1,
        rank: 1,
        name: 'Bitcoin',
        symbol: 'BTC',
        slug: 'bitcoin',
        isActive: 1,
        firstHistoricalData: '2010-07-17T00:00:00Z',
        lastHistoricalData: '2024-10-04T00:00:00Z',
        platform: platform,
      );

      // Assert
      expect(cryptocurrency.id.runtimeType, int);
      expect(cryptocurrency.rank.runtimeType, int);
      expect(cryptocurrency.name.runtimeType, String);
      expect(cryptocurrency.symbol.runtimeType, String);
      expect(cryptocurrency.platform?.name, 'Ethereum');
    });
  });
}
