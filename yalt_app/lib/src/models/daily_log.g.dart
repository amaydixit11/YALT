// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyLogAdapter extends TypeAdapter<DailyLog> {
  @override
  final int typeId = 0;

  @override
  DailyLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyLog(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      mood: fields[2] as int,
      energy: fields[3] as int,
      sleepHours: fields[4] as double,
      waterCups: fields[5] as int,
      customCounters: (fields[6] as Map).cast<String, double>(),
      note: fields[7] as String?,
      tags: (fields[8] as List?)?.cast<String>(),
      updatedAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DailyLog obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.mood)
      ..writeByte(3)
      ..write(obj.energy)
      ..writeByte(4)
      ..write(obj.sleepHours)
      ..writeByte(5)
      ..write(obj.waterCups)
      ..writeByte(6)
      ..write(obj.customCounters)
      ..writeByte(7)
      ..write(obj.note)
      ..writeByte(8)
      ..write(obj.tags)
      ..writeByte(9)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyLog _$DailyLogFromJson(Map<String, dynamic> json) => DailyLog(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      mood: (json['mood'] as num).toInt(),
      energy: (json['energy'] as num).toInt(),
      sleepHours: (json['sleepHours'] as num).toDouble(),
      waterCups: (json['waterCups'] as num).toInt(),
      customCounters: (json['customCounters'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      note: json['note'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DailyLogToJson(DailyLog instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'mood': instance.mood,
      'energy': instance.energy,
      'sleepHours': instance.sleepHours,
      'waterCups': instance.waterCups,
      'customCounters': instance.customCounters,
      'note': instance.note,
      'tags': instance.tags,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };