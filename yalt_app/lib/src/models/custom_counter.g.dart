// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_counter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomCounterAdapter extends TypeAdapter<CustomCounter> {
  @override
  final int typeId = 1;

  @override
  CustomCounter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomCounter(
      id: fields[0] as String,
      name: fields[1] as String,
      unit: fields[2] as String,
      step: fields[3] as double,
      dailyReset: fields[4] as bool,
      trackHistory: fields[5] as bool,
      colorIndex: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CustomCounter obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.step)
      ..writeByte(4)
      ..write(obj.dailyReset)
      ..writeByte(5)
      ..write(obj.trackHistory)
      ..writeByte(6)
      ..write(obj.colorIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomCounterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomCounter _$CustomCounterFromJson(Map<String, dynamic> json) => CustomCounter(
      id: json['id'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      step: (json['step'] as num?)?.toDouble() ?? 1.0,
      dailyReset: json['dailyReset'] as bool? ?? false,
      trackHistory: json['trackHistory'] as bool? ?? true,
      colorIndex: (json['colorIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CustomCounterToJson(CustomCounter instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': instance.unit,
      'step': instance.step,
      'dailyReset': instance.dailyReset,
      'trackHistory': instance.trackHistory,
      'colorIndex': instance.colorIndex,
    };