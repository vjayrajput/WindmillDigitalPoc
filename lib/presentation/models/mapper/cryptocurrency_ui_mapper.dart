import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/models/mapper/platform_ui_mapper.dart';

class CryptocurrencyUiMapper {
  static CryptocurrencyUiModel toUiModel(CryptocurrencyEntity entity) {
    return CryptocurrencyUiModel(
      id: entity.id,
      name: entity.name,
      symbol: entity.symbol,
      slug: entity.slug,
      rank: entity.rank,
      isActive: entity.isActive,
      firstHistoricalData: entity.firstHistoricalData,
      lastHistoricalData: entity.lastHistoricalData,
      platform: entity.platform != null
          ? PlatformUiMapper.toUiModel(entity.platform!)
          : null,
    );
  }
}
