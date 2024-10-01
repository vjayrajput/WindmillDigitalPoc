import 'package:equatable/equatable.dart';
import 'package:windmill_digital_poc/presentation/models/platform_ui_model.dart';

class CryptocurrencyUiModel extends Equatable {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final int rank;
  final String firstHistoricalData;
  final String lastHistoricalData;
  final PlatformUiModel? platform;

  const CryptocurrencyUiModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.rank,
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
        firstHistoricalData,
        lastHistoricalData,
      ];
}
