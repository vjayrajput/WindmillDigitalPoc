import 'package:equatable/equatable.dart';
import 'package:windmill_digital_poc/domain/entities/platform_entity.dart';

class CryptocurrencyEntity extends Equatable {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final int rank;
  final int isActive;
  final String firstHistoricalData;
  final String lastHistoricalData;
  final PlatformEntity? platform;

  const CryptocurrencyEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.rank,
    required this.isActive,
    required this.firstHistoricalData,
    required this.lastHistoricalData,
    required this.platform,
  });

  @override
  List<Object> get props => [
        id,
        name,
        symbol,
        slug,
        rank,
        isActive,
        firstHistoricalData,
        lastHistoricalData,
      ];
}
