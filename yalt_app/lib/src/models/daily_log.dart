import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../core/constants/app_constants.dart';

part 'daily_log.g.dart';

@HiveType(typeId: AppConstants.dailyLogTypeId)
@JsonSerializable()
class DailyLog extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final DateTime date;
  
  @HiveField(2)
  final int mood;
  
  @HiveField(3)
  final int energy;
  
  @HiveField(4)
  final double sleepHours;
  
  @HiveField(5)
  final int waterCups;
  
  @HiveField(6)
  final Map<String, double> customCounters;
  
  @HiveField(7)
  final String? note;
  
  @HiveField(8)
  final List<String>? tags;
  
  @HiveField(9)
  final DateTime updatedAt;
  
  DailyLog({
    required this.id,
    required this.date,
    required this.mood,
    required this.energy,
    required this.sleepHours,
    required this.waterCups,
    required this.customCounters,
    this.note,
    this.tags,
    required this.updatedAt,
  });
  
  factory DailyLog.fromJson(Map<String, dynamic> json) => _$DailyLogFromJson(json);
  Map<String, dynamic> toJson() => _$DailyLogToJson(this);
  
  DailyLog copyWith({
    String? id,
    DateTime? date,
    int? mood,
    int? energy,
    double? sleepHours,
    int? waterCups,
    Map<String, double>? customCounters,
    String? note,
    List<String>? tags,
    DateTime? updatedAt,
  }) {
    return DailyLog(
      id: id ?? this.id,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      energy: energy ?? this.energy,
      sleepHours: sleepHours ?? this.sleepHours,
      waterCups: waterCups ?? this.waterCups,
      customCounters: customCounters ?? this.customCounters,
      note: note ?? this.note,
      tags: tags ?? this.tags,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}