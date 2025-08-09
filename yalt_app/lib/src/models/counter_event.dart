import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../core/constants/app_constants.dart';

part 'counter_event.g.dart';

@HiveType(typeId: AppConstants.counterEventTypeId)
@JsonSerializable()
class CounterEvent extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String counterId;
  
  @HiveField(2)
  final DateTime timestamp;
  
  @HiveField(3)
  final double delta;
  
  @HiveField(4)
  final String? note;
  
  CounterEvent({
    required this.id,
    required this.counterId,
    required this.timestamp,
    required this.delta,
    this.note,
  });
  
  factory CounterEvent.fromJson(Map<String, dynamic> json) => _$CounterEventFromJson(json);
  Map<String, dynamic> toJson() => _$CounterEventToJson(this);
  
  CounterEvent copyWith({
    String? id,
    String? counterId,
    DateTime? timestamp,
    double? delta,
    String? note,
  }) {
    return CounterEvent(
      id: id ?? this.id,
      counterId: counterId ?? this.counterId,
      timestamp: timestamp ?? this.timestamp,
      delta: delta ?? this.delta,
      note: note ?? this.note,
    );
  }
}