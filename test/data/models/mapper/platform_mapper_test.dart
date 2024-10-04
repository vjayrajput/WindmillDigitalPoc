import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/data/models/mapper/platform_mapper.dart';

import '../../../testing_data.dart';

void main() {
  group('PlatformMapper', () {
    test('toEntity should map PlatformModel to PlatformEntity', () {
      // Arrange
      var platformModel = testPlatformModel1;

      // Act
      final entity = PlatformMapper.toEntity(platformModel);

      // Assert
      expect(entity.id, platformModel.id);
      expect(entity.name, platformModel.name);
      expect(entity.symbol, platformModel.symbol);
      expect(entity.slug, platformModel.slug);
      expect(entity.tokenAddress, platformModel.tokenAddress);
    });

    test('toModel should map PlatformEntity to PlatformModel', () {
      // Arrange
      const platformEntity = testPlatformEntity1;

      // Act
      final model = PlatformMapper.toModel(platformEntity);

      // Assert
      expect(model.id, platformEntity.id);
      expect(model.name, platformEntity.name);
      expect(model.symbol, platformEntity.symbol);
      expect(model.slug, platformEntity.slug);
      expect(model.tokenAddress, platformEntity.tokenAddress);
    });
  });
}
