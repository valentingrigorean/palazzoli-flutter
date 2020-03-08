import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';

part 'search_result.g.dart';

@JsonSerializable()
class SearchResultList extends Equatable {
  final List<Subcategory> items;

  SearchResultList({this.items}) : super([items]);

  factory SearchResultList.fromJson(Map<String, dynamic> json) =>
      _$SearchResultListFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultListToJson(this);
}
