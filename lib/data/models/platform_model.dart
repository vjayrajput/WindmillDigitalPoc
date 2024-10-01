import 'package:json_annotation/json_annotation.dart';

part 'platform_model.g.dart';

@JsonSerializable()
class PlatformModel {
  final int id;
  final String name;
  final String symbol;
  final String slug;

  PlatformModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
  });

  factory PlatformModel.fromJson(Map<String, dynamic> json) =>
      _$PlatformModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformModelToJson(this);
}
