import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';
import 'package:windmill_digital_poc/data/models/mapper/platform_mapper.dart';
import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';

class CryptocurrencyMapper {
  static CryptocurrencyEntity toEntity(CryptocurrencyModel model) {
    return CryptocurrencyEntity(
      id: model.id,
      name: model.name,
      symbol: model.symbol,
      slug: model.slug,
      rank: model.rank,
      isActive: model.isActive,
      firstHistoricalData: model.firstHistoricalData ?? "",
      lastHistoricalData: model.lastHistoricalData ?? "",
      platform: model.platform != null
          ? PlatformMapper.toEntity(model.platform!)
          : null,
    );
  }
}
