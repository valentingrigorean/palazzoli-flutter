library favoriteproduct;

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';

part 'favorite_product.g.dart';

@JsonSerializable()
class FavoriteProduct extends Equatable {
  final String productId;
  final Subcategory subcategory;

  FavoriteProduct({this.productId, this.subcategory})
      : super([productId, subcategory]);

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) =>
      _$FavoriteProductFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteProductToJson(this);
}

@JsonSerializable()
class FavoriteProductList extends Equatable {
  final List<FavoriteProduct> items;

  FavoriteProductList({this.items}) : super([items]);

  factory FavoriteProductList.fromJson(Map<String, dynamic> json) =>
      _$FavoriteProductListFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteProductListToJson(this);
}
