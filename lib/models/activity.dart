import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity extends Equatable {
  final int id;
  final String name;

  Activity({this.id, this.name}) : super([id, name]);

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

@JsonSerializable()
class ActivityList extends Equatable {
  final List<Activity> items;

  ActivityList(this.items) : super([items]);

  factory ActivityList.fromJson(Map<String, dynamic> json) =>
      _$ActivityListFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityListToJson(this);
}
