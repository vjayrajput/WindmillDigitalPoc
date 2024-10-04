import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/models/mapper/platform_ui_mapper.dart';

import '../../../testing_data.dart';

void main() {
  group('PlatformUiMapper', () {
    test('toUiModel should map PlatformEntity to PlatformUiModel', () {
      // Arrange
      const platformEntity = testPlatformEntity1;

      // Act
      final uiModel = PlatformUiMapper.toUiModel(platformEntity);

      // Assert
      expect(uiModel.id, platformEntity.id);
      expect(uiModel.name, platformEntity.name);
      expect(uiModel.symbol, platformEntity.symbol);
      expect(uiModel.slug, platformEntity.slug);
      expect(uiModel.tokenAddress, platformEntity.tokenAddress);
    });

    test('toEntity should map PlatformUiModel to PlatformEntity', () {
      // Arrange
      const platformUiModel = testPlatformUiModel1;

      // Act
      final entity = PlatformUiMapper.toEntity(platformUiModel);

      // Assert
      expect(entity.id, platformUiModel.id);
      expect(entity.name, platformUiModel.name);
      expect(entity.symbol, platformUiModel.symbol);
      expect(entity.slug, platformUiModel.slug);
      expect(entity.tokenAddress, platformUiModel.tokenAddress);
    });
  });
}
