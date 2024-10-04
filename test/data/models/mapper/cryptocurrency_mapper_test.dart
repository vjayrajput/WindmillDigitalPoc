import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/data/models/mapper/cryptocurrency_mapper.dart';

import '../../../testing_data.dart';

void main() {
  group('CryptocurrencyUiMapper', () {
    test('toEntity should map CryptocurrencyModel to CryptocurrencyEntity', () {
      // Arrange
      var platformModel = testPlatformModel1;
      var cryptocurrencyModel = testCryptocurrencyModel1;

      // Act
      final entity = CryptocurrencyMapper.toEntity(cryptocurrencyModel);

      // Assert
      expect(entity.id, cryptocurrencyModel.id);
      expect(entity.name, cryptocurrencyModel.name);
      expect(entity.symbol, cryptocurrencyModel.symbol);
      expect(entity.slug, cryptocurrencyModel.slug);
      expect(entity.rank, cryptocurrencyModel.rank);
      expect(entity.isActive, cryptocurrencyModel.isActive);
      expect(
          entity.firstHistoricalData, cryptocurrencyModel.firstHistoricalData);
      expect(entity.lastHistoricalData, cryptocurrencyModel.lastHistoricalData);
      expect(entity.platform, isNotNull);
      expect(entity.platform?.id, platformModel.id);
    });

    test('toModel should map CryptocurrencyEntity to CryptocurrencyModel', () {
      // Arrange
      const platformEntity = testPlatformEntity1;

      const cryptocurrencyEntity = testCryptocurrencyEntity1;

      // Act
      final model = CryptocurrencyMapper.toModel(cryptocurrencyEntity);

      // Assert
      expect(model.id, cryptocurrencyEntity.id);
      expect(model.name, cryptocurrencyEntity.name);
      expect(model.symbol, cryptocurrencyEntity.symbol);
      expect(model.slug, cryptocurrencyEntity.slug);
      expect(model.rank, cryptocurrencyEntity.rank);
      expect(model.isActive, cryptocurrencyEntity.isActive);
      expect(
          model.firstHistoricalData, cryptocurrencyEntity.firstHistoricalData);
      expect(model.lastHistoricalData, cryptocurrencyEntity.lastHistoricalData);
      expect(model.platform, isNotNull);
      expect(model.platform?.id, platformEntity.id);
    });
  });
}
