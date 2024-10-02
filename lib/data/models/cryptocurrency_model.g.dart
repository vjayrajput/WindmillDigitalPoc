// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cryptocurrency_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptocurrencyModelAdapter extends TypeAdapter<CryptocurrencyModel> {
  @override
  final int typeId = 0;

  @override
  CryptocurrencyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptocurrencyModel(
      id: fields[0] as int,
      rank: fields[1] as int,
      name: fields[2] as String,
      symbol: fields[3] as String,
      slug: fields[4] as String,
      isActive: fields[5] as int,
      firstHistoricalData: fields[6] as String?,
      lastHistoricalData: fields[7] as String?,
      platform: fields[8] as PlatformModel?,
    );
  }

  @override
  void write(BinaryWriter writer, CryptocurrencyModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.rank)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.symbol)
      ..writeByte(4)
      ..write(obj.slug)
      ..writeByte(5)
      ..write(obj.isActive)
      ..writeByte(6)
      ..write(obj.firstHistoricalData)
      ..writeByte(7)
      ..write(obj.lastHistoricalData)
      ..writeByte(8)
      ..write(obj.platform);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptocurrencyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptocurrencyModel _$CryptocurrencyModelFromJson(Map<String, dynamic> json) =>
    CryptocurrencyModel(
      id: (json['id'] ?? 0) as int,
      rank: (json['rank'] ?? 0) as int,
      name: (json['name'] ?? "") as String,
      symbol: (json['symbol'] ?? "") as String,
      slug: (json['slug'] ?? "") as String,
      isActive: (json['isActive'] ?? 0) as int,
      firstHistoricalData: (json['firstHistoricalData'] ?? "") as String,
      lastHistoricalData: (json['lastHistoricalData'] ?? "") as String,
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
      'isActive': instance.isActive,
      'firstHistoricalData': instance.firstHistoricalData,
      'lastHistoricalData': instance.lastHistoricalData,
      'platform': instance.platform,
    };
