// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlatformModelAdapter extends TypeAdapter<PlatformModel> {
  @override
  final int typeId = 1;

  @override
  PlatformModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlatformModel(
      id: fields[0] as int,
      name: fields[1] as String,
      symbol: fields[2] as String,
      slug: fields[3] as String,
      tokenAddress: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlatformModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.slug)
      ..writeByte(4)
      ..write(obj.tokenAddress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlatformModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlatformModel _$PlatformModelFromJson(Map<String, dynamic> json) =>
    PlatformModel(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? "") as String,
      symbol: (json['symbol'] ?? "") as String,
      slug: (json['slug'] ?? "") as String,
      tokenAddress: (json['tokenAddress'] ?? "") as String,
    );

Map<String, dynamic> _$PlatformModelToJson(PlatformModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'slug': instance.slug,
      'tokenAddress': instance.tokenAddress,
    };
