// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
      id: json['id'] as String,
      properties: (json['properties'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as String),
      ));
}

Map<String, dynamic> _$ProductToJson(Product instance) =>
    <String, dynamic>{'id': instance.id, 'properties': instance.properties};

ProductList _$ProductListFromJson(Map<String, dynamic> json) {
  return ProductList(
      headers: (json['headers'] as List)?.map((e) => e as String)?.toList(),
      items: (json['items'] as List)
          ?.map((e) =>
              e == null ? null : Product.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{'headers': instance.headers, 'items': instance.items};
