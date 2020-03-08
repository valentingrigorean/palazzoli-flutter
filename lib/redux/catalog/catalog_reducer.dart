import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_state.dart';
import 'package:redux/redux.dart';

final catalogReducer = combineReducers<CatalogState>([
  TypedReducer<CatalogState, LoadedCatalogsAction>(_onLoadedCatalogs),
  TypedReducer<CatalogState, SelectCatalogAction>(_onSelectedCatalog),
  TypedReducer<CatalogState, LoadedCategoryAction>(_onLoadedCategories),
  TypedReducer<CatalogState, SelectCategoryAction>(_onSelectedCategory),
  TypedReducer<CatalogState, LoadedSubcategoryAction>(_onLoadedSubcategories),
  TypedReducer<CatalogState, SelectSubcategoryAction>(_onSelectedSubcategory),
  TypedReducer<CatalogState, LoadedProductAction>(_onLoadedProducts),
  TypedReducer<CatalogState, SelectProductAction>(_onSelectedProduct),
  TypedReducer<CatalogState, LoadedProductDetailAction>(_onLoadedProductDetail)
]);

CatalogState _onLoadedCatalogs(
    CatalogState state, LoadedCatalogsAction action) {
  return CatalogState(catalogs: action.items);
}

CatalogState _onSelectedCatalog(
    CatalogState state, SelectCatalogAction action) {
  return CatalogState(
      catalogs: state.catalogs, selectedCatalog: action.catalog);
}

CatalogState _onLoadedCategories(
    CatalogState state, LoadedCategoryAction action) {
  return CatalogState(
      catalogs: state.catalogs,
      selectedCatalog: state.selectedCatalog,
      categories: action.items);
}

CatalogState _onSelectedCategory(
    CatalogState state, SelectCategoryAction action) {
  return CatalogState(
      catalogs: state.catalogs,
      selectedCatalog: state.selectedCatalog,
      categories: state.categories,
      selectedCategory: action.category);
}

CatalogState _onLoadedSubcategories(
    CatalogState state, LoadedSubcategoryAction action) {
  return CatalogState(
      catalogs: state.catalogs,
      selectedCatalog: state.selectedCatalog,
      categories: state.categories,
      selectedCategory: state.selectedCategory,
      subcategories: action.items);
}

CatalogState _onSelectedSubcategory(
    CatalogState state, SelectSubcategoryAction action) {
  return CatalogState(
    catalogs: state.catalogs,
    selectedCatalog: state.selectedCatalog,
    categories: state.categories,
    selectedCategory: state.selectedCategory,
    subcategories: state.subcategories,
    selectedSubcategory: action.subcategory,
  );
}

CatalogState _onLoadedProducts(CatalogState state, LoadedProductAction action) {
  return CatalogState(
      catalogs: state.catalogs,
      selectedCatalog: state.selectedCatalog,
      categories: state.categories,
      selectedCategory: state.selectedCategory,
      subcategories: state.subcategories,
      selectedSubcategory: state.selectedSubcategory,
      products: action.items);
}

CatalogState _onSelectedProduct(
    CatalogState state, SelectProductAction action) {
  return CatalogState(
      catalogs: state.catalogs,
      selectedCatalog: state.selectedCatalog,
      categories: state.categories,
      selectedCategory: state.selectedCategory,
      subcategories: state.subcategories,
      selectedSubcategory: state.selectedSubcategory,
      products: state.products,
      selectedProduct: action.product);
}

CatalogState _onLoadedProductDetail(
    CatalogState state, LoadedProductDetailAction action) {
  return CatalogState(
      catalogs: state.catalogs,
      selectedCatalog: state.selectedCatalog,
      categories: state.categories,
      selectedCategory: state.selectedCategory,
      subcategories: state.subcategories,
      selectedSubcategory: state.selectedSubcategory,
      products: state.products,
      selectedProduct: state.selectedProduct,
      productDetail: action.productDetail);
}
