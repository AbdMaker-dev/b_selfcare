import 'package:b_selfcare/src/data/models/products_model.dart';
import 'package:b_selfcare/src/data/models/wallet_model.dart';
import 'package:b_selfcare/src/data/services/http_helper.dart';
// import 'package:b_selfcare/src/views/widgets/plan_card.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'products_state.dart';
part 'products_cubit.freezed.dart';

@lazySingleton
class ProductsCubit extends Cubit<ProductsState> {
  final HttpHelper _httpHelper;
  ProductsCubit(this._httpHelper) : super(ProductsState.initial());

  List<ProductsModel> products = [];
  List<WalletModel> wallets = [];

  Future<void> fetchProducts() async {
    if (products.isNotEmpty) return;
    emit(ProductsState.productsLoading());
    final response = await _httpHelper.handleGetRequest("products/custom", showLoader: true);
    response.fold(
      (left) => emit(ProductsState.productsError(left.message)),
      (right) {
        final list = right.response?['data'] as List<dynamic>? ?? [];
        products = list.whereType<Map<String, dynamic>>().map(ProductsModel.fromJson).toList();
        emit(ProductsState.productsLoaded());
      },
    );
  }

  Future<void> fetchWallets() async {
    if (wallets.isNotEmpty) return;
    emit(ProductsState.walletsLoading());
    final response = await _httpHelper.handleGetRequest("wallets", showLoader: true);
    response.fold(
      (left) => emit(ProductsState.walletsError(left.message)),
      (right) {
        final list = right.response?['data'] as List<dynamic>? ?? [];
        wallets = list.whereType<Map<String, dynamic>>().map(WalletModel.fromJson).toList();
        emit(ProductsState.walletsLoaded());
      },
    );
  }

  Future<void> updateProduct({required int productId, required String name, String? description, required List<Map<String, dynamic>> quotas}) async {
    emit(ProductsState.updateProductLoading());
    final response = await _httpHelper.handlePutRequest(
      "products/custom/$productId",
      {
        "name": name,
        if (description != null && description.isNotEmpty) "description": description,
        "quotas": quotas,
      },
    );
    response.fold(
      (left) => emit(ProductsState.updateProductError(left.message)),
      (right) {
        products = [];
        fetchProducts();
        emit(ProductsState.updateProductSuccess());
      },
    );
  }

  Future<void> archiveProduct(int productId) async {
    emit(ProductsState.archiveProductLoading());
    final response = await _httpHelper.handlePatchRequest(
      "products/custom/$productId/archive",
    );
    response.fold(
      (left) => emit(ProductsState.archiveProductError(left.message)),
      (right) {
        products = [];
        fetchProducts();
        emit(ProductsState.archiveProductSuccess());
      },
    );
  }

  Future<void> createProductsBulk({required String name, String? description, required List<Map<String, dynamic>> quotas}) async {
    emit(ProductsState.createProductsLoading());
    final response = await _httpHelper.handlePostRequest(
      "products/custom",
      {
        "name": name,
        if (description != null && description.isNotEmpty) "description": description,
        "quotas": quotas,
      },
    );
    response.fold(
      (left) => emit(ProductsState.createProductsError(left.message)),
      (right) {
        products = [];
        fetchProducts();
        emit(ProductsState.createProductsSuccess());
      },
    );
  }
}
