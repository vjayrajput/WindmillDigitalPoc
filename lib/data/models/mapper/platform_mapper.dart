import 'package:windmill_digital_poc/data/models/platform_model.dart';
import 'package:windmill_digital_poc/domain/entities/platform_entity.dart';

class PlatformMapper {
  static PlatformEntity toEntity(PlatformModel model) {
    return PlatformEntity(
      id: model.id,
      name: model.name,
      symbol: model.symbol,
      slug: model.slug,
      tokenAddress: model.tokenAddress,
    );
  }

  static PlatformModel toModel(PlatformEntity entity) {
    return PlatformModel(
      id: entity.id,
      name: entity.name,
      symbol: entity.symbol,
      slug: entity.slug,
      tokenAddress: entity.tokenAddress,
    );
  }
}
