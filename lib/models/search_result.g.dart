// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultList _$SearchResultListFromJson(Map<String, dynamic> json) {
  return SearchResultList(
      items: (json['items'] as List)
          ?.map((e) => e == null
              ? null
              : Subcategory.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SearchResultListToJson(SearchResultList instance) =>
    <String, dynamic>{'items': instance.items};
