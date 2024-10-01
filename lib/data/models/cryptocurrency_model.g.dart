// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cryptocurrency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptocurrencyModel _$CryptocurrencyModelFromJson(Map<String, dynamic> json) =>
    CryptocurrencyModel(
      id: (json['id'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      slug: json['slug'] as String,
      firstHistoricalData: json['firstHistoricalData'] as String?,
      lastHistoricalData: json['lastHistoricalData'] as String?,
      platform: json['platform'] == null
          ? null
          : PlatformModel.fromJson(json['platform'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CryptocurrencyModelToJson(
        CryptocurrencyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rank': instance.rank,
      'name': instance.name,
      'symbol': instance.symbol,
      'slug': instance.slug,
      'firstHistoricalData': instance.firstHistoricalData,
      'lastHistoricalData': instance.lastHistoricalData,
      'platform': instance.platform,
    };
