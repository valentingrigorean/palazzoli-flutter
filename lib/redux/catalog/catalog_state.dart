import 'package:equatable/equatable.dart';
import 'package:lightingPalazzoli/models/catalog.dart';
import 'package:lightingPalazzoli/models/category.dart';
import 'package:lightingPalazzoli/models/product.dart';
import 'package:lightingPalazzoli/models/product_detail.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:meta/meta.dart';

@immutable
class CatalogState extends Equatable {
  final List<Catalog> catalogs;
  final Catalog selectedCatalog;
  final List<Category> categories;
  final Category selectedCategory;
  final List<Subcategory> subcategories;
  final Subcategory selectedSubcategory;
  final ProductList products;
  final Product selectedProduct;
  final ProductDetail productDetail;

  CatalogState(
      {this.catalogs,
      this.selectedCatalog,
      this.categories,
      this.selectedCategory,
      this.subcategories,
      this.selectedSubcategory,
      this.products,
      this.selectedProduct,
      this.productDetail})
      : super([
          catalogs,
          selectedCatalog,
          categories,
          selectedCategory,
          subcategories,
          selectedSubcategory,
          products,
          selectedSubcategory,
          productDetail
        ]);
}
