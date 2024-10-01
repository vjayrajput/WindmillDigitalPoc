import 'package:json_annotation/json_annotation.dart';
import 'package:windmill_digital_poc/data/models/platform_model.dart';

part 'cryptocurrency_model.g.dart';

@JsonSerializable()
class CryptocurrencyModel {
  final int id;
  final int rank;
  final String name;
  final String symbol;
  final String slug;
  final String? firstHistoricalData;
  final String? lastHistoricalData;
  final PlatformModel? platform;

  CryptocurrencyModel({
    required this.id,
    required this.rank,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.firstHistoricalData,
    required this.lastHistoricalData,
    this.platform,
  });

  factory CryptocurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CryptocurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CryptocurrencyModelToJson(this);
}

class Status {
  final bool isFavorite;

  Status({required this.isFavorite});
}
