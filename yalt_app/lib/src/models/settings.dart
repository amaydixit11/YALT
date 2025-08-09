import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../core/constants/app_constants.dart';

part 'settings.g.dart';

@HiveType(typeId: AppConstants.settingsTypeId)
@JsonSerializable()
class Settings extends HiveObject {
  @HiveField(0)
  final bool useEncryption;
  
  @HiveField(1)
  final bool autoBackup;
  
  @HiveField(2)
  final String themeMode;
  
  @HiveField(3)
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final TimeOfDay? dailyReminderTime;
  
  @HiveField(4)
  final bool analyticsOptIn;
  
  @HiveField(5)
  final String locale;
  
  @HiveField(6)
  final int dbVersion;
  
  Settings({
    this.useEncryption = false,
    this.autoBackup = false,
    this.themeMode = 'system',
    this.dailyReminderTime,
    this.analyticsOptIn = false,
    this.locale = 'en',
    this.dbVersion = 1,
  });
  
  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);
  
  static TimeOfDay? _timeFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return TimeOfDay(hour: json['hour'], minute: json['minute']);
  }
  
  static Map<String, dynamic>? _timeToJson(TimeOfDay? time) {
    if (time == null) return null;
    return {'hour': time.hour, 'minute': time.minute};
  }
  
  Settings copyWith({
    bool? useEncryption,
    bool? autoBackup,
    String? themeMode,
    TimeOfDay? dailyReminderTime,
    bool? analyticsOptIn,
    String? locale,
    int? dbVersion,
  }) {
    return Settings(
      useEncryption: useEncryption ?? this.useEncryption,
      autoBackup: autoBackup ?? this.autoBackup,
      themeMode: themeMode ?? this.themeMode,
      dailyReminderTime: dailyReminderTime ?? this.dailyReminderTime,
      analyticsOptIn: analyticsOptIn ?? this.analyticsOptIn,
      locale: locale ?? this.locale,
      dbVersion: dbVersion ?? this.dbVersion,
    );
  }
}