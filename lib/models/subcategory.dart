library subcategory;

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subcategory.g.dart';

@JsonSerializable()
class Subcategory extends Equatable {
  final int id;
  final String name;
  final String body;
  final String image;
  final String atribute;
  final String type;
  @JsonKey(name: 'product_codes')
  final String productCodes;
  final String level;

  Subcategory(
      {this.id,
      this.name,
      this.body,
      this.image,
      this.atribute,
      this.type,
      this.productCodes,
      this.level})
      : super([id, name, body, image, atribute, type, productCodes, level]);

  factory Subcategory.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryToJson(this);
}

@JsonSerializable()
class SubcategoryList extends Equatable {
  final List<Subcategory> items;

  SubcategoryList({this.items}) : super([items]);

  factory SubcategoryList.fromJson(Map<String,dynamic> json) => _$SubcategoryListFromJson(json);

  Map<String,dynamic> toJson() => _$SubcategoryListToJson(this);
}
