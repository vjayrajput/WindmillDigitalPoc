// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlatformModel _$PlatformModelFromJson(Map<String, dynamic> json) =>
    PlatformModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$PlatformModelToJson(PlatformModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'slug': instance.slug,
    };
