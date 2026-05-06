part of 'products_cubit.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;


  const factory ProductsState.productsLoading() = _ProductsLoading;
  const factory ProductsState.productsError(String? message) = _ProductsError;
  const factory ProductsState.productsLoaded() = ProductsLoaded;


}
