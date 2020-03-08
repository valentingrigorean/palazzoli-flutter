import 'package:lightingPalazzoli/data/repository.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/app/base_midleware.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';

class CatalogMiddleware extends BaseMiddleware<LoadCatalogsAction> {
  CatalogMiddleware(Repository repository) : super(repository);

  @override
  Stream fetchData(AppState state, action) async* {
    await for (var data in repository.getCatalogs()) {
      yield LoadedCatalogsAction(data);
    }
  }
}

class CategoryMiddleware extends BaseMiddleware<LoadCategoryAction> {
  CategoryMiddleware(Repository repository) : super(repository);

  @override
  Stream fetchData(AppState state, action) async* {
    await for (var data
        in repository.getCategories(state.catalogState.selectedCatalog.id)) {
      yield LoadedCategoryAction(data);
    }
  }
}

class SubcategoryMiddleware extends BaseMiddleware<LoadSubcategoryAction> {
  SubcategoryMiddleware(Repository repository) : super(repository);

  @override
  Stream fetchData(AppState state, action) async* {
    await for (var data in repository
        .getSubcategories(state.catalogState.selectedCategory.id)) {
      yield LoadedSubcategoryAction(data);
    }
  }
}

class ProductMiddleware extends BaseMiddleware<LoadProductAction> {
  ProductMiddleware(Repository repository) : super(repository);

  @override
  Stream fetchData(AppState state, action) async* {
    await for (var data
        in repository.getProducts(state.catalogState.selectedSubcategory)) {
      yield LoadedProductAction(data);
    }
  }
}

class ProductDetailMiddleware extends BaseMiddleware<LoadProductDetailAction> {
  ProductDetailMiddleware(Repository repository) : super(repository);

  @override
  Stream fetchData(AppState state, action) async* {
    await for (var data
        in repository.getProductDetail(action.id, action.type)) {
      yield LoadedProductDetailAction(data);
    }
  }
}
