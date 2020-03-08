import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';

@immutable
class SearchState extends Equatable {
  final int currentPage;
  final bool isLoading;
  final bool hasError;
  final bool canLoadMore;

  final List<Subcategory> items;

  SearchState(
      {this.currentPage = 1,
      this.isLoading = false,
      this.hasError = false,
      this.items = const [],
      this.canLoadMore = true})
      : super([currentPage, isLoading, items, canLoadMore]);

  factory SearchState.loading() => SearchState(isLoading: true);

  factory SearchState.error() => SearchState(hasError: true);

  SearchState copyWith(
      {int currentPage,
      bool isLoading,
      List<Subcategory> items,
      bool canLoadMore}) {
    return SearchState(
        currentPage: currentPage ?? this.currentPage,
        isLoading: isLoading ?? this.isLoading,
        items: items ?? this.items,
        canLoadMore: canLoadMore ?? this.canLoadMore);
  }
}
