import 'package:b_selfcare/src/data/models/products_model.dart';
import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/views/widgets/plan_card.dart';
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

  List<PlanFeature> featuresForProduct(ProductsModel product) {
    final quotas = product.quotas ?? [];
    final features = <PlanFeature>[];
    for (final q in quotas) {
      features.add(PlanFeature(
        label: 'Quota ${q.walletId}',
        value: '${q.quota ?? 0}',
        unit: 'u',
      ));
      if (features.length >= 4) break;
    }
    while (features.length < 4) {
      features.add(const PlanFeature(label: '—', value: '—', unit: ''));
    }
    return features;
  }

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
}
