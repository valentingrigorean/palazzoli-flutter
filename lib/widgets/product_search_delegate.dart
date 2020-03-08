import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/search/search_actions.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_item_widget.dart';
import 'package:redux/redux.dart';

class ProductSearchDelegate<SearchResult> extends SearchDelegate {
  final Key _resultsKey = Key('search_result');
  int _currentPage = 1;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return PalazzoliTheme.of(context)
        .toThemeData()
        .copyWith(primaryColor: Colors.blueAccent);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    var icon = Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back;
    return IconButton(icon: Icon(icon), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _showSearchWidget(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _showSearchWidget(context);
  }

  Widget _showSearchWidget(BuildContext context) {
    _currentPage = 1;
    if (query.length <= 2) {
      return Container();
    }

    var store = StoreProvider.of<AppState>(context);
    store.dispatch(SearchAction(query, page: _currentPage));

    return StoreConnector<AppState, SearchViewModel>(
      key: _resultsKey,
      converter: (store) => SearchViewModel.fromStore(store),
      distinct: true,
      builder: (context, vm) {
        return _LoadMoreListWidget(
            itemCount: vm.items.length + (vm.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == vm.items.length) {
                return _showLoading(context);
              }
              return CatalogItemWidget(
                  item: CatalogItem.fromSubcategory(vm.items[index]),
                  onTap: (item) {
                    close(context, item);
                  });
            },
            onLoadMore: () {
              if (vm.canCanLoadMore && !vm.isLoading) {
                _currentPage++;
                store.dispatch(
                    SearchAction(query, page: _currentPage, items: vm.items));
              }
            });
      },
    );
  }

  Widget _showLoading(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      alignment: Alignment.topCenter,
      child: CircularProgressIndicator(),
    );
  }
}

class _LoadMoreListWidget extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final VoidCallback onLoadMore;

  const _LoadMoreListWidget(
      {Key key, this.itemCount, this.itemBuilder, this.onLoadMore})
      : super(key: key);

  @override
  __LoadMoreListWidgetState createState() => __LoadMoreListWidgetState();
}

class __LoadMoreListWidgetState extends State<_LoadMoreListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      right: false,
      left: false,
      child: ListView.builder(
          controller: _scrollController,
          itemBuilder: widget.itemBuilder,
          itemCount: widget.itemCount),
    );
  }
}

@immutable
class SearchViewModel extends Equatable {
  final bool isLoading;
  final bool hasError;
  final List<Subcategory> items;
  final bool canCanLoadMore;

  SearchViewModel(
      {this.isLoading, this.hasError, this.items, this.canCanLoadMore})
      : super([isLoading, hasError, items, canCanLoadMore]);

  factory SearchViewModel.fromStore(Store<AppState> store) {
    var appState = store.state;

    var state = appState.searchState;

    return SearchViewModel(
        isLoading: state.isLoading,
        hasError: state.hasError,
        canCanLoadMore: state.canLoadMore,
        items: state.items);
  }
}
