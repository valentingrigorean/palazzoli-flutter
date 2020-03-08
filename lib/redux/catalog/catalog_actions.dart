import 'package:lightingPalazzoli/models/catalog.dart';
import 'package:lightingPalazzoli/models/category.dart';
import 'package:lightingPalazzoli/models/product.dart';
import 'package:lightingPalazzoli/models/product_detail.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:lightingPalazzoli/redux/app/app_actions.dart';

class LoadCatalogsAction extends StartLoadingAction {}

class LoadedCatalogsAction extends StopLoadingAction {
  final List<Catalog> items;

  LoadedCatalogsAction(this.items);
}

class SelectCatalogAction {
  final Catalog catalog;

  SelectCatalogAction(this.catalog);
}

class LoadCategoryAction extends StartLoadingAction {
  final int catalogId;

  LoadCategoryAction(this.catalogId);
}

class LoadedCategoryAction extends StopLoadingAction {
  final List<Category> items;

  LoadedCategoryAction(this.items);
}

class SelectCategoryAction {
  final Category category;

  SelectCategoryAction(this.category);
}

class LoadSubcategoryAction extends StartLoadingAction {
  final int categoryId;

  LoadSubcategoryAction(this.categoryId);
}

class LoadedSubcategoryAction extends StopLoadingAction {
  final List<Subcategory> items;

  LoadedSubcategoryAction(this.items);
}

class SelectSubcategoryAction {
  final Subcategory subcategory;

  SelectSubcategoryAction(this.subcategory);
}

class LoadProductAction extends StartLoadingAction {
  final Subcategory subcategory;

  LoadProductAction(this.subcategory);
}

class LoadedProductAction extends StopLoadingAction {
  final ProductList items;

  LoadedProductAction(this.items);
}

class SelectProductAction {
  final Product product;

  SelectProductAction(this.product);
}

class LoadProductDetailAction extends StartLoadingAction {
  final String id;
  final String type;

  LoadProductDetailAction(this.id, this.type);
}

class LoadedProductDetailAction extends StopLoadingAction {
  final ProductDetail productDetail;

  LoadedProductDetailAction(this.productDetail);
}
