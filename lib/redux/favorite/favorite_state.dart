import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lightingPalazzoli/models/favorite_product.dart';

@immutable
class FavoriteState extends Equatable {
  final List<FavoriteProduct> items;

  FavoriteState({this.items}) : super([items]);

  factory FavoriteState.initial() => FavoriteState(items: []);
}
