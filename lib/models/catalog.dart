library catalog;

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'catalog.g.dart';

@JsonSerializable()
class Catalog extends Equatable {

  final int id;
  final String name;
  final String body;
  final String image;

  Catalog({this.id, this.name, this.body, this.image})
      : super([id, name, body, image]);

  factory Catalog.fromJson(Map<String, dynamic> json) => _$CatalogFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogToJson(this);
}

@JsonSerializable()
class CatalogList extends Equatable{

  final  List<Catalog> items;

  CatalogList(this.items):super([items]);

  factory CatalogList.fromJson(Map<String, dynamic> json) => _$CatalogListFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogListToJson(this);
}