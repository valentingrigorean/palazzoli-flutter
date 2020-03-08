// GENERATED CODE - DO NOT MODIFY BY HAND

part of favoriteproduct;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteProduct _$FavoriteProductFromJson(Map<String, dynamic> json) {
  return FavoriteProduct(
      productId: json['productId'] as String,
      subcategory: json['subcategory'] == null
          ? null
          : Subcategory.fromJson(json['subcategory'] as Map<String, dynamic>));
}

Map<String, dynamic> _$FavoriteProductToJson(FavoriteProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'subcategory': instance.subcategory
    };

FavoriteProductList _$FavoriteProductListFromJson(Map<String, dynamic> json) {
  return FavoriteProductList(
      items: (json['items'] as List)
          ?.map((e) => e == null
              ? null
              : FavoriteProduct.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$FavoriteProductListToJson(
        FavoriteProductList instance) =>
    <String, dynamic>{'items': instance.items};
