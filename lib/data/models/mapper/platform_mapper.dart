import 'package:windmill_digital_poc/data/models/platform_model.dart';
import 'package:windmill_digital_poc/domain/entities/platform_entity.dart';

class PlatformMapper {
  static PlatformEntity toEntity(PlatformModel model) {
    return PlatformEntity(
      id: model.id ?? 0,
      name: model.name ?? "",
      symbol: model.symbol ?? "",
      slug: model.slug ?? "",
    );
  }
}
