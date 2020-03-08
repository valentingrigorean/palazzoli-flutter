// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailInfo _$MailInfoFromJson(Map<String, dynamic> json) {
  return MailInfo(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      type: json['type'] as int,
      codeProduct: json['code_product'] as String,
      message: json['message'] as String);
}

Map<String, dynamic> _$MailInfoToJson(MailInfo instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'type': instance.type,
      'code_product': instance.codeProduct,
      'message': instance.message
    };
