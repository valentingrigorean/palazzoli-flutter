import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_detail.g.dart';

@JsonSerializable()
class ProductDetail extends Equatable {
  final String code;
  final String infoBody;
  @JsonKey(name: 'data_technical')
  final Map<String, String> technicalData;
  @JsonKey(name: 'data_personal')
  final Map<String, String> personalData;
  @JsonKey(name: 'data_statements')
  final List<String> statements;
  @JsonKey(name: 'data_downloads')
  final Map<String, String> downloads;

  ProductDetail(
      {this.code,
      this.infoBody,
      this.technicalData,
      this.personalData,
      this.statements,
      this.downloads})
      : super([
          code,
          infoBody,
          technicalData,
          personalData,
          statements,
          downloads
        ]);

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);
}

@JsonSerializable()
class ProductDetailList extends Equatable {
  final List<ProductDetail> items;

  ProductDetailList(this.items) : super([items]);

  ProductDetail getItem() =>
      items == null || items.length == 0 ? null : items[0];

  factory ProductDetailList.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailListFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailListToJson(this);
}
