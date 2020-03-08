// GENERATED CODE - DO NOT MODIFY BY HAND

part of category;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
      id: json['id'] as int,
      title: json['name'] as String,
      body: json['body'] as String,
      image: json['image'] as String);
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.title,
      'body': instance.body,
      'image': instance.image
    };

CategoryList _$CategoryListFromJson(Map<String, dynamic> json) {
  return CategoryList((json['items'] as List)
      ?.map((e) =>
          e == null ? null : Category.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$CategoryListToJson(CategoryList instance) =>
    <String, dynamic>{'items': instance.items};
