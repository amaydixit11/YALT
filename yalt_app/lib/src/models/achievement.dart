import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../core/constants/app_constants.dart';

part 'achievement.g.dart';

@HiveType(typeId: AppConstants.achievementTypeId)
@JsonSerializable()
class Achievement extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final bool unlocked;
  
  @HiveField(4)
  final DateTime? unlockedAt;
  
  @HiveField(5)
  final String iconName;
  
  Achievement({
    required this.id,
    required this.title,
    required this.description,
    this.unlocked = false,
    this.unlockedAt,
    required this.iconName,
  });
  
  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);
  Map<String, dynamic> toJson() => _$AchievementToJson(this);
  
  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    bool? unlocked,
    DateTime? unlockedAt,
    String? iconName,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      unlocked: unlocked ?? this.unlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      iconName: iconName ?? this.iconName,
    );
  }
}