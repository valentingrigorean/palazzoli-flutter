import 'package:lightingPalazzoli/models/subcategory.dart';

class SearchLoadingAction {}

class SearchErrorAction {}

class ClearSearchAction {}

class SearchAction extends SearchLoadingAction {
  final String query;
  final int page;
  final List<Subcategory> items;

  SearchAction(this.query, {this.page = 1, this.items = const []});
}

class SearchResultAction {
  final List<Subcategory> items;
  final bool canLoadMore;

  SearchResultAction(this.items, this.canLoadMore);
}
