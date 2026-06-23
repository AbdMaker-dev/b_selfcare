part of 'products_cubit.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;


  const factory ProductsState.productsLoading() = _ProductsLoading;
  const factory ProductsState.productsError(String? message) = _ProductsError;
  const factory ProductsState.productsLoaded() = ProductsLoaded;

  const factory ProductsState.walletsLoading() = _WalletsLoading;
  const factory ProductsState.walletsError(String? message) = _WalletsError;
  const factory ProductsState.walletsLoaded() = _WalletsLoaded;

  const factory ProductsState.createProductsLoading() = _CreateProductsLoading;
  const factory ProductsState.createProductsError(String? message) = _CreateProductsError;
  const factory ProductsState.createProductsSuccess() = _CreateProductsSuccess;

  const factory ProductsState.updateProductLoading() = _UpdateProductLoading;
  const factory ProductsState.updateProductError(String? message) = _UpdateProductError;
  const factory ProductsState.updateProductSuccess() = _UpdateProductSuccess;

  const factory ProductsState.archiveProductLoading() = _ArchiveProductLoading;
  const factory ProductsState.archiveProductError(String? message) = _ArchiveProductError;
  const factory ProductsState.archiveProductSuccess() = _ArchiveProductSuccess;

  const factory ProductsState.nativeProductsLoading() = _NativeProductsLoading;
  const factory ProductsState.nativeProductsError(String? message) = _NativeProductsError;
  const factory ProductsState.nativeProductsLoaded() = _NativeProductsLoaded;

  const factory ProductsState.groupedProductsLoading() = _GroupedProductsLoading;
  const factory ProductsState.groupedProductsError(String? message) = _GroupedProductsError;
  const factory ProductsState.groupedProductsLoaded() = _GroupedProductsLoaded;
}
