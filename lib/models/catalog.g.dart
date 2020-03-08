// GENERATED CODE - DO NOT MODIFY BY HAND

part of catalog;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Catalog _$CatalogFromJson(Map<String, dynamic> json) {
  return Catalog(
      id: json['id'] as int,
      name: json['name'] as String,
      body: json['body'] as String,
      image: json['image'] as String);
}

Map<String, dynamic> _$CatalogToJson(Catalog instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'body': instance.body,
      'image': instance.image
    };

CatalogList _$CatalogListFromJson(Map<String, dynamic> json) {
  return CatalogList((json['items'] as List)
      ?.map(
          (e) => e == null ? null : Catalog.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$CatalogListToJson(CatalogList instance) =>
    <String, dynamic>{'items': instance.items};
