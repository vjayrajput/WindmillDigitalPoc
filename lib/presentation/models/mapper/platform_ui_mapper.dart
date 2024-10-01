import 'package:windmill_digital_poc/domain/entities/platform_entity.dart';
import 'package:windmill_digital_poc/presentation/models/platform_ui_model.dart';

class PlatformUiMapper {
  static PlatformUiModel toUiModel(PlatformEntity entity) {
    return PlatformUiModel(
      id: entity.id ?? 0,
      name: entity.name ?? "",
      symbol: entity.symbol ?? "",
      slug: entity.slug ?? "",
    );
  }
}
