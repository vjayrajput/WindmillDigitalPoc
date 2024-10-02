import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'platform_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class PlatformModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String symbol;

  @HiveField(3)
  final String slug;

  @HiveField(4)
  final String tokenAddress;

  PlatformModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.tokenAddress,
  });

  factory PlatformModel.fromJson(Map<String, dynamic> json) =>
      _$PlatformModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformModelToJson(this);
}
