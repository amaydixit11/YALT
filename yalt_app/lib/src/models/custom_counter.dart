import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../core/constants/app_constants.dart';

part 'custom_counter.g.dart';

@HiveType(typeId: AppConstants.customCounterTypeId)
@JsonSerializable()
class CustomCounter extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String unit;
  
  @HiveField(3)
  final double step;
  
  @HiveField(4)
  final bool dailyReset;
  
  @HiveField(5)
  final bool trackHistory;
  
  @HiveField(6)
  final int colorIndex;
  
  CustomCounter({
    required this.id,
    required this.name,
    required this.unit,
    this.step = 1.0,
    this.dailyReset = false,
    this.trackHistory = true,
    this.colorIndex = 0,
  });
  
  factory CustomCounter.fromJson(Map<String, dynamic> json) => _$CustomCounterFromJson(json);
  Map<String, dynamic> toJson() => _$CustomCounterToJson(this);
  
  CustomCounter copyWith({
    String? id,
    String? name,
    String? unit,
    double? step,
    bool? dailyReset,
    bool? trackHistory,
    int? colorIndex,
  }) {
    return CustomCounter(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      step: step ?? this.step,
      dailyReset: dailyReset ?? this.dailyReset,
      trackHistory: trackHistory ?? this.trackHistory,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }
}