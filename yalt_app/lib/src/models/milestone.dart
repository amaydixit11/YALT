import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../core/constants/app_constants.dart';

part 'milestone.g.dart';

@HiveType(typeId: AppConstants.milestoneTypeId)
@JsonSerializable()
class Milestone extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final DateTime date;
  
  @HiveField(3)
  final String? note;
  
  @HiveField(4)
  final String? imageFilePath;
  
  @HiveField(5)
  final DateTime createdAt;
  
  Milestone({
    required this.id,
    required this.title,
    required this.date,
    this.note,
    this.imageFilePath,
    required this.createdAt,
  });
  
  factory Milestone.fromJson(Map<String, dynamic> json) => _$MilestoneFromJson(json);
  Map<String, dynamic> toJson() => _$MilestoneToJson(this);
  
  Milestone copyWith({
    String? id,
    String? title,
    DateTime? date,
    String? note,
    String? imageFilePath,
    DateTime? createdAt,
  }) {
    return Milestone(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      note: note ?? this.note,
      imageFilePath: imageFilePath ?? this.imageFilePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}