library category;

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final int id;
  @JsonKey(name: 'name')
  final String title;
  final String body;
  final String image;

  Category({this.id, this.title, this.body, this.image})
      : super([id, title, body, image]);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class CategoryList extends Equatable {
  final List<Category> items;

  CategoryList(this.items) : super([items]);

  factory CategoryList.fromJson(Map<String, dynamic> json) =>
      _$CategoryListFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListToJson(this);
}
