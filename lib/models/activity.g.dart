// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(id: json['id'] as int, name: json['name'] as String);
}

Map<String, dynamic> _$ActivityToJson(Activity instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

ActivityList _$ActivityListFromJson(Map<String, dynamic> json) {
  return ActivityList((json['items'] as List)
      ?.map((e) =>
          e == null ? null : Activity.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$ActivityListToJson(ActivityList instance) =>
    <String, dynamic>{'items': instance.items};
