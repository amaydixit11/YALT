// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 5;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings(
      useEncryption: fields[0] as bool,
      autoBackup: fields[1] as bool,
      themeMode: fields[2] as String,
      dailyReminderTime: fields[3] as TimeOfDay?,
      analyticsOptIn: fields[4] as bool,
      locale: fields[5] as String,
      dbVersion: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.useEncryption)
      ..writeByte(1)
      ..write(obj.autoBackup)
      ..writeByte(2)
      ..write(obj.themeMode)
      ..writeByte(3)
      ..write(obj.dailyReminderTime)
      ..writeByte(4)
      ..write(obj.analyticsOptIn)
      ..writeByte(5)
      ..write(obj.locale)
      ..writeByte(6)
      ..write(obj.dbVersion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      useEncryption: json['useEncryption'] as bool? ?? false,
      autoBackup: json['autoBackup'] as bool? ?? false,
      themeMode: json['themeMode'] as String? ?? 'system',
      dailyReminderTime: Settings._timeFromJson(
          json['dailyReminderTime'] as Map<String, dynamic>?),
      analyticsOptIn: json['analyticsOptIn'] as bool? ?? false,
      locale: json['locale'] as String? ?? 'en',
      dbVersion: (json['dbVersion'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'useEncryption': instance.useEncryption,
      'autoBackup': instance.autoBackup,
      'themeMode': instance.themeMode,
      'dailyReminderTime': Settings._timeToJson(instance.dailyReminderTime),
      'analyticsOptIn': instance.analyticsOptIn,
      'locale': instance.locale,
      'dbVersion': instance.dbVersion,
    };