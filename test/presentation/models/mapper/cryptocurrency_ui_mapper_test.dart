import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/models/mapper/cryptocurrency_ui_mapper.dart';

import '../../../testing_data.dart';

void main() {
  group('CryptocurrencyUiMapper', () {
    test('toUiModel should map CryptocurrencyEntity to CryptocurrencyUiModel',
        () {
      // Arrange
      const platformEntity = testPlatformEntity1;

      const cryptoEntity = testCryptocurrencyEntity1;

      // Act
      final uiModel = CryptocurrencyUiMapper.toUiModel(cryptoEntity);

      // Assert
      expect(uiModel.id, cryptoEntity.id);
      expect(uiModel.name, cryptoEntity.name);
      expect(uiModel.symbol, cryptoEntity.symbol);
      expect(uiModel.slug, cryptoEntity.slug);
      expect(uiModel.rank, cryptoEntity.rank);
      expect(uiModel.isActive, cryptoEntity.isActive);
      expect(uiModel.firstHistoricalData, cryptoEntity.firstHistoricalData);
      expect(uiModel.lastHistoricalData, cryptoEntity.lastHistoricalData);
      expect(uiModel.platform, isNotNull);
      expect(uiModel.platform?.id, platformEntity.id);
    });

    test('toEntity should map CryptocurrencyUiModel to CryptocurrencyEntity',
        () {
      // Arrange
      const platformUiModel = testPlatformUiModel1;
      const cryptoUiModel = testCryptocurrencyUiModel1;

      // Act
      final entity = CryptocurrencyUiMapper.toEntity(cryptoUiModel);

      // Assert
      expect(entity.id, cryptoUiModel.id);
      expect(entity.name, cryptoUiModel.name);
      expect(entity.symbol, cryptoUiModel.symbol);
      expect(entity.slug, cryptoUiModel.slug);
      expect(entity.rank, cryptoUiModel.rank);
      expect(entity.isActive, cryptoUiModel.isActive);
      expect(entity.firstHistoricalData, cryptoUiModel.firstHistoricalData);
      expect(entity.lastHistoricalData, cryptoUiModel.lastHistoricalData);
      expect(entity.platform, isNotNull);
      expect(entity.platform?.id, platformUiModel.id);
    });
  });
}
