import 'package:windmill_digital_poc/domain/entities/platform_entity.dart';
import 'package:windmill_digital_poc/presentation/models/platform_ui_model.dart';

class PlatformUiMapper {
  static PlatformUiModel toUiModel(PlatformEntity entity) {
    return PlatformUiModel(
      id: entity.id,
      name: entity.name,
      symbol: entity.symbol,
      slug: entity.slug,
      tokenAddress: entity.tokenAddress,
    );
  }

  static PlatformEntity toEntity(PlatformUiModel uiModel) {
    return PlatformEntity(
      id: uiModel.id,
      name: uiModel.name,
      symbol: uiModel.symbol,
      slug: uiModel.slug,
      tokenAddress: uiModel.tokenAddress,
    );
  }
}
