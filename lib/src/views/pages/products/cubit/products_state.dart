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
}
