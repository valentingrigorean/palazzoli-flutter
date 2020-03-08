// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) {
  return Register(
      email: json['email'] as String,
      name: json['first_name'] as String,
      surname: json['last_name'] as String,
      businessName: json['business_name'] as String,
      selectActivity: json['activity_id'] as String,
      common: json['common'] as String,
      province: json['province'] as String,
      nation: json['country'] as String,
      phone: json['phone'] as String);
}

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'email': instance.email,
      'first_name': instance.name,
      'last_name': instance.surname,
      'business_name': instance.businessName,
      'activity_id': instance.selectActivity,
      'common': instance.common,
      'province': instance.province,
      'country': instance.nation,
      'phone': instance.phone
    };
