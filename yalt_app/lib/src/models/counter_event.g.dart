// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounterEventAdapter extends TypeAdapter<CounterEvent> {
  @override
  final int typeId = 2;

  @override
  CounterEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CounterEvent(
      id: fields[0] as String,
      counterId: fields[1] as String,
      timestamp: fields[2] as DateTime,
      delta: fields[3] as double,
      note: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CounterEvent obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.counterId)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.delta)
      ..writeByte(4)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounterEvent _$CounterEventFromJson(Map<String, dynamic> json) => CounterEvent(
      id: json['id'] as String,
      counterId: json['counterId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      delta: (json['delta'] as num).toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$CounterEventToJson(CounterEvent instance) => <String, dynamic>{
      'id': instance.id,
      'counterId': instance.counterId,
      'timestamp': instance.timestamp.toIso8601String(),
      'delta': instance.delta,
      'note': instance.note,
    };