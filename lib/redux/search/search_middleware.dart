import 'package:equatable/equatable.dart';
import 'package:lightingPalazzoli/data/network/catalog_api.dart';
import 'package:lightingPalazzoli/data/sharedpref/shared_preference_helper.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/search/search_actions.dart';
import 'package:quiver/strings.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class SearchMiddleware implements EpicClass<AppState> {
  final Map<_SearchQuery, List<Subcategory>> _cache =
      <_SearchQuery, List<Subcategory>>{};
  final CatalogApi _catalogApi;

  SearchMiddleware(this._catalogApi);

  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<SearchAction>())
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((action) => _search(action));
  }

  Stream<dynamic> _search(SearchAction action) async* {
    try {
      var currentLanguage = await SharedPreferenceHelper().currentLanguage;
      var searchQuery =
          _SearchQuery(action.page, action.query, currentLanguage.languageCode);
      if (isBlank(action.query)) {
        yield SearchResultAction([], true);
      } else if (_cache.containsKey(searchQuery)) {
        yield SearchResultAction(_cache[searchQuery], true);
      } else {
        var results = await _catalogApi.searchProducts(
            searchQuery.term, searchQuery.page);

        var items = results.items + action.items;
        _cache[searchQuery] = items;
        yield SearchResultAction(items, results.items.isNotEmpty);
      }
    } catch (e) {
      print(e);
      yield SearchErrorAction();
    }
  }
}

class _SearchQuery extends Equatable {
  final int page;
  final String term;
  final String lang;

  _SearchQuery(this.page, this.term, this.lang) : super([page, term, lang]);
}
