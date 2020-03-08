// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) {
  return ProductDetail(
      code: json['code'] as String,
      infoBody: json['infoBody'] as String,
      technicalData: (json['data_technical'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      personalData: (json['data_personal'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      statements:
          (json['data_statements'] as List)?.map((e) => e as String)?.toList(),
      downloads: (json['data_downloads'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as String),
      ));
}

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'code': instance.code,
      'infoBody': instance.infoBody,
      'data_technical': instance.technicalData,
      'data_personal': instance.personalData,
      'data_statements': instance.statements,
      'data_downloads': instance.downloads
    };

ProductDetailList _$ProductDetailListFromJson(Map<String, dynamic> json) {
  return ProductDetailList((json['items'] as List)
      ?.map((e) =>
          e == null ? null : ProductDetail.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$ProductDetailListToJson(ProductDetailList instance) =>
    <String, dynamic>{'items': instance.items};
