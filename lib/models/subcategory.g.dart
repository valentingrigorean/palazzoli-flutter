// GENERATED CODE - DO NOT MODIFY BY HAND

part of subcategory;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subcategory _$SubcategoryFromJson(Map<String, dynamic> json) {
  return Subcategory(
      id: json['id'] as int,
      name: json['name'] as String,
      body: json['body'] as String,
      image: json['image'] as String,
      atribute: json['atribute'] as String,
      type: json['type'] as String,
      productCodes: json['product_codes'] as String,
      level: json['level'] as String);
}

Map<String, dynamic> _$SubcategoryToJson(Subcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'body': instance.body,
      'image': instance.image,
      'atribute': instance.atribute,
      'type': instance.type,
      'product_codes': instance.productCodes,
      'level': instance.level
    };

SubcategoryList _$SubcategoryListFromJson(Map<String, dynamic> json) {
  return SubcategoryList(
      items: (json['items'] as List)
          ?.map((e) => e == null
              ? null
              : Subcategory.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SubcategoryListToJson(SubcategoryList instance) =>
    <String, dynamic>{'items': instance.items};
