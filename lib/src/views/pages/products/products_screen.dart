import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/products/cubit/products_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_empty.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _cubit = getIt<ProductsCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 20.rh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.textHighlight(
            "Mes produits",
            highlight: "produits",
            fontSize: 22.rsp,
            fontFamily: FontFamily.syne,
          ),
          SizedBox(height: 8.rh),
          AppText(
            "FORFAITS PERSONNALISÉS · COMPUTED_COST AUTO",
            fontSize: 11.rsp,
            color: AppColors.textMuted,
          ),
          SizedBox(height: 30.rh),
          BlocSelector<ProductsCubit, ProductsState, ProductsLoaded?>(
            bloc: _cubit,
            selector: (state) => state is ProductsLoaded ? ProductsLoaded() : null,
            builder: (context, state){ 
              if (_cubit.products.isEmpty) {
                return const AppEmpty(
                  icon: Icons.inventory_2_outlined,
                  title: 'Aucun produit',
                  subtitle: 'Vous n\'avez pas encore de produits configurés.',
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.rw,
                  mainAxisSpacing: 16.rh,
                  childAspectRatio: 470 / 179,
                ),
                itemCount: _cubit.products.length,
                itemBuilder: (_, i) {
                  final product = _cubit.products[i];
                  return PlanCard(
                    name: product.name ?? '—',
                    status: product.isActive == true ? PlanStatus.active : PlanStatus.archive,
                    features: _cubit.featuresForProduct(product),
                  );
                },
              );
            }
          ),
        ],
      ),
    );
  }
}
