import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:windmill_digital_poc/data/models/platform_model.dart';

part 'cryptocurrency_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class CryptocurrencyModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int rank;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String symbol;

  @HiveField(4)
  final String slug;

  @HiveField(5)
  final int isActive;

  @HiveField(6)
  final String? firstHistoricalData;

  @HiveField(7)
  final String? lastHistoricalData;

  @HiveField(8)
  final PlatformModel? platform;

  CryptocurrencyModel({
    required this.id,
    required this.rank,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.isActive,
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
